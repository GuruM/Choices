
class StudentsController < ApplicationController

  before_filter :authenticate, :only => [:admin, :admin_all, :destroy, :su_edit, :admin_update]
  
  # GET /students
  # GET /students.xml
  def index
    #hitting DB way too many times, should optimize
    @groups = Option.find(:all, :order => "id ASC", :conditions=> "option_type = 0")
    @committees = Option.find(:all, :order => "id ASC", :conditions=> "option_type = 1")
    
    @students = Student.find(:all)
    @students_count = Student.find(:all, :conditions=> "option_id <> 36").length
    @recent_students = Student.find(:all, :order => "created_at DESC", :limit => 5)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @students }
    end
  end
  
  def message
    
  end

  # GET /students/new
  # GET /students/new.xml
  def new
    @student = Student.new
    @students = Student.find(:all, :conditions => "option_id = 36")
    @student.password = "";

    @groups = Option.find(:all, :order => "id ASC", :conditions=> "option_type = 0 AND id <> 36")
    @committees = Option.find(:all, :order => "id ASC", :conditions=> "option_type = 1")

  
  #	@student = Student.new
#	@students = Student.find(:all, :order => "name ASC", :conditions=>"option_id IS NULL")
    # @student.option_id = params[:id] if params[:id]
    
 #   @groups = Option.find(:all, :order => "id ASC", :conditions=> "option_type = 0 AND name != 'Missing'")
 #   @committees = Option.find(:all, :order => "id ASC", :conditions=> "option_type = 1")


#    respond_to do |format|
#      format.html # new.html.erb
#      format.xml  { render :xml => @student }
#    end 
  end

  # GET /students/1/edit
  def edit
    @student = Student.find(params[:id])
    @student.password = "";

    @groups = Option.find(:all, :order => "id ASC", :conditions=> "option_type = 0 AND id <> 36")
    @committees = Option.find(:all, :order => "id ASC", :conditions=> "option_type = 1")

  end

  # POST /students
  # POST /students.xml
  def create
    @student = Student.new(params[:student])
	@student.option_id = 36 #assign to Missing
	
    respond_to do |format|
      if @student.save
        flash[:notice] = 'Student was successfully created.'
        format.html { redirect_to(:controller=>"students",:action => "admin_all")  }
        format.xml  { render :xml => @student, :status => :created, :location => @student }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @student.errors, :status => :unprocessable_entity }
      end
    end
  end


  # PUT /students/1
  # PUT /students/1.xml
  def update
	flash[:error] =""
	if params[:student][:id].blank?
		flash[:error] += '*** Pick yourself from the list of formal names! '
	end
	if params[:student][:nickname].blank?
		flash[:error] += '*** Set your friendly name! '
	end
	if params[:student][:password].blank?
		flash[:error] += '*** Set your password! '
	end
	if params[:student][:option_id].blank?
		flash[:error] += '*** Select your option! There is an "Undecided" option if you\'re undecided. '
	end
	if !(flash[:error].blank?)
		redirect_to (:controller=>"students",:action=>"new")
		return
	end
  
	if params[:student][:id].blank?
		@student = Student.find(params[:id]) #this block of code seems ... wrong
	else
		@student = Student.find(params[:student][:id]) #this block of code seems ... wrong
	end
	@student.email = params[:student][:email]
	@student.nickname = params[:student][:nickname]
	if @student.password.blank?
		@student.password = params[:student][:password]
	end
	@student.option_id = params[:student][:option_id]
	
    respond_to do |format|
      if (params[:student][:password] && (@student.password == params[:student][:password]) && @student.update_attributes(params[:student]))
          flash[:notice] = 'Student was successfully updated.'
          format.html { redirect_to(students_url) }
          format.xml  { head :ok }
        else
          flash[:notice] = 'Incorrect Password. Try Again.'
          format.html { redirect_to(edit_student_path(@student)) }
          format.xml  { render :xml => @student.errors, :status => :unprocessable_entity }
        end
    end
  end
  
  
    def admin_update
    @student = Student.find(params[:id])

    respond_to do |format|
      if (@student.update_attributes(params[:student]))
          flash[:notice] = 'Student was successfully updated.'
          format.html { redirect_to(:controller=>"students",:action => "admin_all") }
          format.xml  { head :ok }
        else
          flash[:notice] = 'Failed.'
          format.html { redirect_to(edit_student_path(@student)) }
          format.xml  { render :xml => @student.errors, :status => :unprocessable_entity }
        end
    end
  end

def admin
  @students = Student.find(:all)
  @added = Student.find(:all, :order => "created_at DESC", :limit => 10)
  @updated = Student.find(:all, :order => "updated_at DESC", :limit => 10)
end

def admin_all
  @students = Student.find(:all, :order => "id DESC")
  @st = Student.new
  @options = Option.all
  @op = Option.new
  @options.each do |option|
      Option.update_counters option.id, :students_count => -option.students_count
      Option.update_counters option.id, :students_count => option.students.length
  end
end

def update_options

end


def su_edit
    @student = Student.find(params[:id])

    @groups = Option.find(:all, :order => "id ASC", :conditions=> "option_type = 0")
    @committees = Option.find(:all, :order => "id ASC", :conditions=> "option_type = 1")
end

def destroy
    @student = Student.find(params[:id])
    @student.destroy

    respond_to do |format|
      flash[:notice] = 'Student was successfully destroyed.'
      format.html { redirect_to(:action => "admin") }
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
