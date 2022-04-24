class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def confirm
    @contact = Contact.new(contact_params)
    if @contact.invalid?
      render :new
    end
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.send_mail(@contact).deliver_now
      redirect_to thanks_contacts_path
    end
  end

  def thanks
  end

  private

  def contact_params
    params.require(:contact).permit(:name,:email,:subject,:message)
  end

end
