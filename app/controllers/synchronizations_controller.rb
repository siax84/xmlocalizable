class SynchronizationsController < ApplicationController
  before_action :set_synchronization, only: [:show, :edit, :update, :destroy, :map, :save_localizable]

  # GET /synchronizations
  # GET /synchronizations.json
  def index
    @synchronizations = Synchronization.all
  end
  
  def map
    unless params[:index].blank?
      params[:index].each do |index|
        index = index.to_i
        mapping = Mapping.find_by(
          :source_field_id => params[:source_field_ids][index],
          :synchronization_id => @synchronization
          )      
        if params[:target_field_ids][index].blank?
          mapping.target_field_id = nil
        else  
          mapping.target_field_id = params[:target_field_ids][index]          
        end
        mapping.save
      end     
      
    end  
    respond_to do |format|
      format.html
    end    
  end
  
  def save_localizable
    mappings = Mapping.includes(:source_field).includes(:target_field).where(:synchronization_id => @synchronization).where('target_field_id IS NOT NULL')
    if @synchronization.target_platform == 'iOS'
      @output = ''
      @synchronization.target_document.each_line do |line|            
        mappings.each do |mapping|
          if line.include?(mapping.target_field.to_s) && line.blank? == false
            line = "\"#{mapping.target_field.to_s}\" = \"#{mapping.common_value}\""
          end          
        end
        @output += line + "</br>"                
      end            
    end
    respond_to do |format|
        format.html 
    end    
  end

  # GET /synchronizations/1
  # GET /synchronizations/1.json
  def show
  end

  # GET /synchronizations/new
  def new
    @synchronization = Synchronization.new
  end

  # GET /synchronizations/1/edit
  def edit
  end

  # POST /synchronizations
  # POST /synchronizations.json
  def create
    @synchronization = Synchronization.new(synchronization_params)

    respond_to do |format|
      if @synchronization.save
        format.html { redirect_to @synchronization, notice: 'Synchronization was successfully created.' }
        format.json { render :show, status: :created, location: @synchronization }
      else
        format.html { render :new }
        format.json { render json: @synchronization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /synchronizations/1
  # PATCH/PUT /synchronizations/1.json
  def update
    respond_to do |format|
      if @synchronization.update(synchronization_params)
        format.html { redirect_to @synchronization, notice: 'Synchronization was successfully updated.' }
        format.json { render :show, status: :ok, location: @synchronization }
      else
        format.html { render :edit }
        format.json { render json: @synchronization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /synchronizations/1
  # DELETE /synchronizations/1.json
  def destroy
    @synchronization.destroy
    respond_to do |format|
      format.html { redirect_to synchronizations_url, notice: 'Synchronization was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_synchronization
      @synchronization = Synchronization.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def synchronization_params
      params.require(:synchronization).permit(:name, :source_platform, :source_document, :target_platform, :target_document)
    end
end
