module CommonActions
  extend ActiveSupport::Concern

  included do
    before_action :check_read_permission, only: [:index,:show]
    before_action :check_write_permission, only: [:create,:update,:destroy]
    before_action :find_obj, except: [:index,:create,:search,:all]
  end

  def index
    obj_klass =  eval(resource_name)
    render json: {
      collection: obj_klass.order("ID DESC").not_deleted.search(query_params).by_limit(params[:page],10),
      metadata:  {count: obj_klass.not_deleted.count, current_page: params[:page]}
    }
  end

  def all
    render json: eval(resource_name).where_like(params[:column],params[:query]).not_deleted.order("ID DESC").limit(10)
  end

  def search_fullname
    render json: eval(resource_name).where_name_like(params["columns"].values,params[:query]).not_deleted.order("ID DESC").limit(10)
  end

  def create
    @obj = eval(resource_name).new(obj_params)
    if @obj.save
      ResourceLogger::Processor.perform_async('create',@obj.previous_changes,current_user.attributes,@obj.id,@obj.class.name) if Rails.env != 'test'
      render_obj
    else
      obj_errors
    end
  end

  def show
    render_obj
  end

  def update
    if @obj.update_attributes(obj_params)
      ResourceLogger::Processor.perform_async('update',@obj.previous_changes,current_user.attributes,@obj.id,@obj.class.name) if Rails.env != 'test'
      render_obj
    else
      obj_errors
    end
  end

  def destroy
    if @obj.update(deleted_at: Time.current)
      ResourceLogger::Processor.perform_async('delete',@obj.previous_changes,current_user.attributes,@obj.id,@obj.class.name) if Rails.env != 'test'
      render_success
    else
      obj_errors
    end
  end

  protected

  def check_read_permission
    unless validate_permission(resource_name.tableize.singularize,"read")
      fail ApiExceptions::UnauthorizedAccessError
    end
  end

  def check_write_permission
    unless validate_permission(resource_name.tableize.singularize,"write")
      fail ApiExceptions::UnauthorizedAccessError
    end
  end

  #
  # NOTE: resource_name must be defined inside a controller
  #
  def find_obj
    @obj = eval(resource_name).where(id: params[:id]).not_deleted[0]
  end

  def query_params
    @query_params ||= params[:query].present? ? JSON.parse(params[:query].gsub('=>', ':')) : {}
  end
end
