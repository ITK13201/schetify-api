require 'base64'

module Links
  class ShareController < ApplicationController
    skip_before_action :authenticate, only: :redirect_share_link
    skip_before_action :find_user, only: :redirect_share_link
    def redirect_share_link
      decoded_params = Base64.decode64(params[:sid].delete("\n"))
      redirect_to "schetify://events/?#{decoded_params}", allow_other_host: true
    end
  end
end
