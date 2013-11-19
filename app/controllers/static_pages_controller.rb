class StaticPagesController < ApplicationController

  layout "application"
  def home
  end

  def show
    begin
      render params[:page].to_sym
    rescue ActionView::MissingTemplate
      raise ActionController::RoutingError.new('Not Found')
    end
  end
end
