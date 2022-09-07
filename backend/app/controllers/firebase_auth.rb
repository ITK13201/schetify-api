# frozen_string_literal: true

require 'net/http'

class FirebaseAuth
  class InvalidTokenError < StandardError; end
  CERTS_URI = 'https://www.googleapis.com/robot/v1/metadata/x509/securetoken@system.gserviceaccount.com'
  CERTS_CACHE_KEY = 'firebase_auth_certificates'
  PROJECT_ID = ENV.fetch('PROJECT_ID', nil)
  JWT_OPTION = {
    algorithm: 'RS256',
    iss: "https://securetoken.google.com/#{PROJECT_ID}",
    verify_iss: true,
    aud: PROJECT_ID, # 各々の環境で
    verify_aud: true,
    verify_iat: true
  }.freeze

  def self.authenticate(token)
    payload, = JWT.decode(token, nil, true, JWT_OPTION) do |header|
      cert = fetch_certificates[header['kid']]
      OpenSSL::X509::Certificate.new(cert).public_key if cert.present?
    end
    raise InvalidTokenError, 'Invalid auth_time' unless Time.zone.at(payload['auth_time']).past?
    raise InvalidTokenError, 'Invalid sub' if payload['sub'].empty?

    payload['user_id']
  end

  def self.fetch_certificates
    cached = Rails.cache.read(CERTS_CACHE_KEY)
    return cached if cached.present?

    res = fetch_certs_uri
    body = JSON.parse(res.body)
    expires_at = Time.zone.parse(res.header['expires'])
    Rails.cache.write(CERTS_CACHE_KEY, body, expires_in: expires_at - Time.current)
    body
  end

  def self.fetch_certs_uri
    res = Net::HTTP.get_response(URI(CERTS_URI))
    raise 'Fetch certificates error' unless res.is_a?(Net::HTTPSuccess)

    res
  end
end
