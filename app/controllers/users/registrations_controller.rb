# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
    #before_action :redirect_unless_admin, only: [:new, :create]
   # before_action :authenticate_admin!, only: [:new, :create]
  before_action :authenticate_user!, only: [:new, :create]
  before_action :authenticate_is_admin!, only: [:new, :create]


  # GET /resource/sign_up
   def new
    #super
    #agregado
    @user = User.new
   end

  # POST /resource
    def create
      super
    # Verifica si ya existe algún usuario en la base de datos
    is_first_user = User.count == 0
    
    # Crea un nuevo usuario con los parámetros del formulario de Sign Up
    @user = User.new(user_params)
    
    # Si es el primer usuario, asigna true a is_admin
    @user.is_admin = is_first_user
    
    # Guarda el usuario y maneja los casos de éxito y error
    if @user.save
      flash[:notice] = "Usuario creado exitosamente."
      redirect_to root_path # Redirige a una ruta deseada después de crear el usuario
    else
      flash[:alert] = "Error al crear el usuario. Por favor, revisa los campos."
      render :new
    end
  end




  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  private

  # Método fuerte para permitir solo los parámetros necesarios
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
  end

  def redirect_unless_admin
    if user_signed_in? && !current_user.is_admin
      redirect_to root_path, alert: 'No tienes permisos para crear un usuario.'
    end
  end
end
