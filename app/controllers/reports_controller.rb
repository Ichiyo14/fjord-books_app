# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: %i[show edit update destroy]
  before_action :correct_user, only: %i[edit update destroy]
  before_action :unique_report_at_date_for_each_user, only: %i[create]
  # GET /reports or /reports.json
  def index
    @reports = Report.all.includes(:user).order(id: 'DESC').page(params[:page])
  end

  # GET /reports/1
  def show; end

  # GET /reports/new
  def new
    @report = Report.new
  end

  # GET /reports/1/edit
  def edit; end

  # POST /reports
  def create
    @report = current_user.reports.new(report_params)
    respond_to do |format|
      if @report.save
        format.html { redirect_to @report, notice: t(:notice_create, scope: 'controllers.common', name: Report.model_name.human) }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1
  def update
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to @report, notice: t(:notice_update, scope: 'controllers.common', name: Report.model_name.human) }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  def destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to reports_url, notice: t(:notice_destroy, scope: 'controllers.common', name: Report.model_name.human) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_report
    @report = Report.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def report_params
    params.require(:report).permit(:title, :content, :user_id)
  end

  def correct_user
    report = Report.find(params[:id])
    redirect_to(reports_path) unless report.user == current_user
  end

  def unique_report_at_date_for_each_user
    user = User.find(current_user.id)
    reports = user.reports.all.order(id: :ASC)
    return unless reports.map { |report| report.created_at.to_date }.include?(DateTime.now.to_date)

    redirect_to(edit_report_path(reports.last.id), notice: t(:notice_created_today, scope: 'controllers.common', name: Report.model_name.human))
  end
end
