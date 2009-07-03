class SantaController < ApplicationController
  def say
    if msg = params[:q]
      cookies[:name] = params[:name]
      if msg.blank?
        flash[:notice] = "Message is clearly not optional. Ho ho ho."
      elsif msg.length <= 160
        RecentPost.create!(:message => msg, :source_ip => request.remote_ip, :name => params[:name])
        nabaztag.say!(params[:q])
        flash[:notice] = "Message sent. Ho ho ho."
      else
        flash[:notice] = "Message too long. Ho ho ho."
      end
    end
    redirect_to root_path
  end

  def index
    @name = cookies[:name]
    @recent_posts = RecentPost.scoped(:order => "created_at").last(20).reverse
  end

  def nabaztag
    @nabaztag ||= Nabaztag.new(ENV["Nabaztag_Serial"], ENV["Nabaztag_Key"]).tap{|n| n.voice = "UK-Leonard" }
  end
end
