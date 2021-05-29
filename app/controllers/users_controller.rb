# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show]
  def show; end

  def index
    @users = User.order(:id).page(params[:page]).per(3)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
