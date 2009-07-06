class SantaController < ApplicationController
  def say
    return preview if params[:preview]
    cookies[:name] = params[:name]
    validate_message(params[:q]) do |msg|
      RecentPost.create!(:message => msg, :source_ip => request.remote_ip, :name => params[:name])
      nabaztag.say!(msg)
      flash[:notice] = "Santa says “#{msg}”"
      flash[:preview_url] = nabaztag.preview_say!(msg)
    end
    redirect_to root_path
  end

  def preview
    cookies[:name] = params[:name]
    validate_message(params[:q]) do |msg|
      flash[:preview_url] = nabaztag.preview_say!(msg)
    end

    respond_to do |wants|
      wants.html{ redirect_to root_path }
      wants.json{ render :json => flash.delete(:preview_url)}
    end
  end

  def does_baywatch
    nabaztag.play!(root_url + "sounds/baywatch.mp3")
    redirect_to root_path
  end

  def index
    @name = cookies[:name]
    @recent_posts = RecentPost.scoped(:order => "created_at").last(20).reverse
  end
private
  def validate_message(msg)
    if msg.blank?
      flash[:notice] = "Message is clearly not optional. Ho ho ho."
    elsif msg.length > 160
      flash[:notice] = "Message too long. Ho ho ho."
    else
      yield msg
    end
  end
  def nabaztag
    @nabaztag ||= Nabaztag.new(ENV["Nabaztag_Serial"], ENV["Nabaztag_Key"]).tap{|n| n.voice = "UK-Leonard" }
  end
end
