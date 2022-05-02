class Admin::ContactsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @contacts = Contact.page(params[:page]).order(id: :desc)
  end

  def edit
    @contact = Contact.find(params[:id])
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact.update(contact_params)
      redirect_to admin_contacts_path
    else
      render :edit
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:is_action)
  end

end
