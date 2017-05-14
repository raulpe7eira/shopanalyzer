require 'rails_helper'

RSpec.describe SuppliersController, :type => :controller do

  login_user

  let(:suppliers) { create_list :valid_supplier, 4, user: subject.current_user }

  describe 'GET #index' do
    before(:each) { get :index }

    it 'responds successfully with an HTTP 200 status code' do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end

    it 'loads all suppliers into the @suppliers' do
      expect(assigns(:suppliers)).to match_array(suppliers)
    end
  end

  describe 'GET #new' do
    before(:each) { get :new }

    it 'responds successfully with an HTTP 200 status code' do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders the new template' do
      expect(response).to render_template(:new)
    end

    it 'instantiates a new supplier' do
      supplier = assigns(:supplier)

      expect(supplier).to be_kind_of ActiveRecord::Base
      expect(supplier).not_to be_persisted
      expect(supplier.user).to eq(subject.current_user)

      expect(suppliers).not_to include(supplier)
    end
  end

  describe 'GET #edit' do
    let(:edit_supplier) { suppliers.sample }

    before(:each) { get :edit, params: { id: edit_supplier.id } }

    it 'responds successfully with an HTTP 200 status code' do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders the edit template' do
      expect(response).to render_template(:edit)
    end

    it 'instantiates a edit supplier' do
      supplier = assigns(:supplier)

      expect(supplier).to be_kind_of(ActiveRecord::Base)
      expect(supplier).to be_persisted
      expect(supplier.user).to eq(subject.current_user)
      expect(supplier).to eq(edit_supplier)
    end
  end

  describe 'POST #create' do
    before(:each) { post :create, params: { supplier: { ** new_supplier } } }

    context 'when valid supplier' do
      let(:new_supplier) { attributes_for(:valid_supplier) }

      it 'redirect to suppliers path if the supplier was created' do
        expect(flash[:notice]).to eq('messages.created')
        expect(response).to redirect_to(suppliers_path)
      end
    end

    context 'when invalid supplier' do
      let(:new_supplier) { attributes_for(:invalid_supplier) }

      it 'renders a new action if the supplier was not created' do
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH/PUT #update' do
    let(:edit_supplier) { suppliers.sample }

    before(:each) { patch :update, params: { id: edit_supplier.id, supplier: { ** new_values } } }

    context 'when valid supplier' do
      let(:new_values) { attributes_for(:valid_supplier) }

      it 'redirect to suppliers path if the supplier was updated' do
        expect(flash[:notice]).to eq('messages.updated')
        expect(response).to redirect_to(suppliers_path)
      end
    end

    context 'when invalid supplier' do
      let(:new_values) { attributes_for(:invalid_supplier) }

      it 'renders a edit action if the supplier was not updated' do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) { delete :destroy, params: { id: destroy_supplier.id } }

    context 'when valid supplier' do
      let(:destroy_supplier) { suppliers.sample }

      it 'redirect to suppliers path if the supplier was destroyed' do
        expect(flash[:notice]).to eq('messages.destroyed')
        expect(response).to redirect_to(suppliers_path)
      end
    end

    context 'when invalid supplier' do
      let(:destroy_supplier) { build :invalid_supplier }

      it 'renders a root path if the supplier was not destroyed' do
        expect(flash[:alert]).to eq('messages.error.notfound')
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when supplier has dependents' do
      let(:sales) { create_list :valid_sale, 1, user: subject.current_user }
      let(:destroy_supplier) { sales.sample.supplier }

      it 'renders a root path if the supplier was not destroyed' do
        expect(flash[:alert]).to eq('messages.error.dependents')
        expect(response).to redirect_to(root_path)
      end
    end
  end

end
