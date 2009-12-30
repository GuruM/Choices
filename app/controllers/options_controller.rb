class OptionsController < ApplicationController

  before_filter :authenticate, :only => [ :create, :update, :destroy]

  
  def create
    @option = Option.new(params[:option])

    respond_to do |format|
      if @option.save
        flash[:notice] = 'Option was successfully created.'
        format.html { redirect_to(:controller=>"students",:action => "admin_all") }
        format.xml  { render :xml => @option, :status => :created, :location => @option }
      else
        format.html { redirect_to(:controller=>"students",:action => "admin_all") }
        format.xml  { render :xml => @option.errors, :status => :unprocessable_entity }
      end
    end
  end

  
  def update
    @option = Option.find(params[:id])

    respond_to do |format|
      if (@option.update_attributes(params[:option]))
          flash[:notice] = 'Option was successfully updated.'
          format.html { redirect_to(:controller=>"students",:action => "admin_all") }
          format.xml  { head :ok }
      else
          flash[:notice] = 'Action failed.'
          format.html { redirect_to(:controller=>"students",:action => "admin_all") }
          format.xml  { render :xml => @option.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update_all
  end
  
  
  def destroy
    @option = Option.find(params[:id])
    @option.destroy

    respond_to do |format|
      flash[:notice] = 'Option was successfully destroyed.'
      format.html { redirect_to(:controller=>"students",:action => "admin_all") }
      format.xml  { head :ok }
    end
  end

protected

def authenticate
  authenticate_or_request_with_http_basic do |username, password|
    username == "admin" && password == "fuckyouall"
  end
end

end
