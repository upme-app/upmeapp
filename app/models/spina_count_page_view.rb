class SpinaCountPageView < ApplicationRecord

  def self.increment(page, request)
    last_view = SpinaCountPageView
        .where(ip: request.remote_ip)
        .where(page_id: page.id)
        .order(id: :desc)
        .limit(1).first

    if !last_view or last_view.created_at + 1.hour < Time.now
      SpinaCountPageView.create({
        page_id: page.id,
        ip: request.remote_ip
      })
    end

  end

  def self.top_page_every_time
    count = SpinaCountPageView.select(:page_id).all.group(:page_id).order(:page_id).count(:page_id)
    if count.size > 0
      page_id = count.sort_by { |a, b| b }.last.first
      return Spina::Page.where(id: page_id).first
    end
    nil
  end

end
