# frozen_string_literal: true
class Admin::DataSourcesController < AdminController
  before_action :set_admin_data_source, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json

  def index
    @search = DataSource.ransack(params[:q])
    @admin_data_sources =
      @search.
      result(distinct: true).
      paginate(page: params[:page], per_page: 30).
      order(:name)
  end

  def new
    @admin_data_source = DataSource.new
  end

  def edit; end

  def create
    @admin_data_source = DataSource.new(admin_data_source_params)

    if @admin_data_source.save
      redirect_to admin_data_sources_path, notice: "Data Source was successfully created."
    else
      render :new
    end
  end

  def update
    if @admin_data_source.update(admin_data_source_params)
      redirect_to admin_data_sources_url, notice: "Data Source was successfully updated."
    end
  end

  def destroy
    if @admin_data_source.destroy
      redirect_to admin_data_sources_url, notice: "Data Source was successfully deleted."
    end
  end

  def csv_report
    @admin_data_sources = DataSource.order(:id)
    respond_to do |format|
      format.html
      format.csv { send_data @admin_data_sources.to_csv, filename: "export_data_sources.csv" }
    end
  end

  private

  def set_admin_data_source
    @admin_data_source = DataSource.find(params[:id])
  end

  def admin_data_source_params
    params.require(:data_source).permit(:hcrm_data_source_id, :name, :provider_type)
  end
end
