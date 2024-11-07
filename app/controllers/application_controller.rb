class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :captura_admin  


  def captura_admin
    # Buscar el primer usuario que tenga el rol de administrador
    first_admin = User.find_by(is_admin: true)
    @first_user = first_admin&.email # Usa `&` para evitar errores si no hay un administrador
  end



  def configure_permitted_parameters
    # Permite los nuevos campos para registro y actualización de cuenta
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :avatar, :is_admin])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :avatar, :is_admin])
  end

end
