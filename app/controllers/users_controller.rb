# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show following followers]
  def index
    @users = User.with_attached_avatar.order(:id).page(params[:page])
  end

  def show; end

  def following
    @title = Relationship.human_attribute_name(:following)
    @users = @user.following.page(params[:page])
    render 'show_follow'
  end

  def followers
    @title = Relationship.human_attribute_name(:followers)
    @users = @user.followers.page(params[:page])
    render 'show_follow'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
