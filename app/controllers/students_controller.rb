class StudentsController < ApplicationController
	before_action :set_student, only: %i[update edit_modal destroy]
	def index
		@students = current_user.students.paginate(page: params[:page], per_page: 10).order('updated_at desc')
	end

	def create
		if student_params[:name].present? && student_params[:subject].present?
			name 		= student_params[:name].downcase
			subject = student_params[:subject].downcase
			mark 		= student_params[:mark]
			@student = Student.find_by(name: name, subject: subject, user_id: current_user.id)
			if @student.present? && @student.update(mark: mark)
				flash[:warning] = 'Student With Same Subject Already Exists Updated The Mark'
				redirect_to students_path
			else
				@student = Student.new(lower_student_params.merge({user_id: current_user.id}))
				if @student.save
					flash[:success] = 'Student Added Successfully'
					redirect_to students_path
				end
			end
		else 
			flash[:error]= 'Error Adding User'
			redirect_to students_path
		end
	end

	def lower_student_params
		student_params.transform_values do |value|
		  value.is_a?(String) ? value.downcase : value
		end
	end


	def edit_modal
		@student = Student.find(params[:id])
		render 'edit_modal.js', layout: false
	end

	def new_modal
		render 'new_modal.js', layout: false
	end

	def update
		
		if @student.update(lower_student_params)
			flash[:success] = 'Student Updated Successfully'
			redirect_to students_path
		end
	end

	def destroy
		if @student.destroy
			flash[:danger] = 'Student Deleted'
			redirect_to students_path
		end
	end

	private

	def student_params
		params.require(:student).permit(:name, :subject, :mark)
	end

	def set_student
		@student = Student.find(params[:id])
	end
end
