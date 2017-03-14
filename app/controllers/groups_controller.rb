class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  # GET /groups
  def index
    @groups = current_user.groups
  end

  # GET /groups/1
  def show
  end

  # GET /groups/new
  def new
    @group = current_user.groups.build
    @members = @group.members.build
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  def create
    @group = current_user.groups.create(group_params)

    if @group.valid?
      @group.member_ids = params[:group][:member].map(&:to_i)
      redirect_to @group, notice: 'Group was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /groups/1
  def update
    if @group.update(group_params)
      @group.member_ids = params[:group][:member].map(&:to_i)
      redirect_to @group, notice: 'Group was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /groups/1
  def destroy
    @group.destroy
    redirect_to groups_url, notice: 'Group was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = current_user.groups.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def group_params
      params.require(:group).permit(:name)
    end
end
