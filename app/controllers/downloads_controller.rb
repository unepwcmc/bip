class DownloadsController < ApplicationController
  def show
    page = Comfy::Cms::Page.find_by_slug(params[:page])
    url = File.join(request.protocol + page.site.hostname, page.full_path)

    rasterizer = Rails.root.join("vendor/assets/javascripts/rasterize.js")
    dest_pdf = Rails.root.join("tmp/#{page.slug.gsub(" ", "-")}.pdf").to_s

    cmd = "phantomjs #{rasterizer} '#{url}' '#{dest_pdf}' A4"

    p cmd
    `#{cmd}`

    send_file dest_pdf, type: 'application/pdf'
  end
end
