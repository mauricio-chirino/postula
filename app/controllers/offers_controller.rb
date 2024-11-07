class OffersController < ApplicationController
  before_action :set_offer, only: [:show, :edit, :update, :destroy]




  def index
    @offers = Offer.all
    @is_admin = User.find_by(is_admin: true)
    @requests = Request.all
  end



  def show
    # No es necesario cargar todas las ofertas aquí, ya que @offer ya está definido en set_offer
    # solo se puede dejar vacío o agregar un comentario si es necesario
  end




  def postular
    @offer = Offer.find(params[:id])
    # Aquí va la lógica para el proceso de postulación
    # Ejemplo: Registrar al usuario actual para la oferta
    
    # if current_user.apply_to_offer(@offer) # Asume que existe un método `apply_to_offer`
    #   flash[:notice] = "Has postulado exitosamente a la oferta."
    # else
    #   flash[:alert] = "No se pudo completar la postulación."
    # end
    # redirect_to offers_path
    #***************************************
    # Aquí puedes implementar la lógica de postulación
    # Por ejemplo, podrías asociar al usuario actual con la oferta:
    current_user.offers << @offer

    redirect_to offers_path, notice: "Has postulado a la oferta exitosamente."
  end



  def requests
    @offer = Offer.find(params[:id])

    # Crear la solicitud si no existe
    if current_user.offers.exists?(@offer.id)
      redirect_to offers_path, alert: "Ya has solicitado esta oferta."
    else
      current_user.offers << @offer
      redirect_to offers_path, notice: "Has solicitado la oferta exitosamente."
      #desactivar boton
    end

  end



  def edit
  end




  def new
    @offer = Offer.new
  end




  def create
    @offer = Offer.new(offer_params)
    if @offer.save
      redirect_to offers_path, notice: 'La oferta fue creada exitosamente.'
    else
      render :new
    end
  end





  def update
    if @offer.update(offer_params)
      redirect_to @offer, notice: 'La oferta fue actualizada exitosamente.'
    else
      render :edit
    end
  end



  def destroy
    @offer.destroy
    redirect_to offers_path, notice: 'La oferta fue eliminada exitosamente.'
  end





  private

  def set_offer
    @offer = Offer.find(params[:id])
  end

  def offer_params
    params.require(:offer).permit(:title, :description, :price)
  end
end