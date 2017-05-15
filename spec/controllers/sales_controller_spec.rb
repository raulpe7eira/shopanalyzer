require 'rails_helper'

RSpec.describe SalesController, :type => :controller do

  login_user

  let(:sales) { create_list :valid_sale, 4, user: subject.current_user }

  describe 'GET #index' do
    before(:each) { get :index }

    it 'responds successfully with an HTTP 200 status code' do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end

    it 'loads all sales into the @sales' do
      expect(assigns(:sales)).to match_array(sales)
    end

    it 'loads total sales into the @total' do
      # TODO: @total not implement yet
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

    it 'instantiates a new sale' do
      sale = assigns(:sale)

      expect(sale).to be_kind_of ActiveRecord::Base
      expect(sale).not_to be_persisted
      expect(sale.user).to eq(subject.current_user)

      expect(sales).not_to include(sale)
    end
  end

  describe 'GET #edit' do
    let(:edit_sale) { sales.sample }

    before(:each) { get :edit, params: { id: edit_sale.id } }

    it 'responds successfully with an HTTP 200 status code' do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders the edit template' do
      expect(response).to render_template(:edit)
    end

    it 'instantiates a edit sale' do
      sale = assigns(:sale)

      expect(sale).to be_kind_of(ActiveRecord::Base)
      expect(sale).to be_persisted
      expect(sale.user).to eq(subject.current_user)
      expect(sale).to eq(edit_sale)
    end
  end

  describe 'GET #import' do
    before(:each) { get :import }

    it 'responds successfully with an HTTP 200 status code' do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders the import template' do
      expect(response).to render_template(:import)
    end
  end

  describe 'POST #create' do
    let(:shopper)  { { :shopper_id => sales.sample.shopper.id } }
    let(:product)  { { :product_id => sales.sample.product.id } }
    let(:supplier) { { :supplier_id => sales.sample.supplier.id } }

    before(:each)  { post :create, params: { sale: { ** new_sale.merge(shopper).merge(product).merge(supplier) } } }

    context 'when valid sale' do
      let(:new_sale) { attributes_for(:valid_sale) }

      it 'redirect to sales path if the sale was created' do
        expect(flash[:notice]).to eq('messages.created')
        expect(response).to redirect_to(sales_path)
      end
    end

    context 'when invalid sale' do
      let(:new_sale) { attributes_for(:invalid_sale) }

      it 'renders a new action if the sale was not created' do
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH/PUT #update' do
    let(:edit_sale) { sales.sample }

    let(:shopper)   { { :shopper_id => edit_sale.shopper.id } }
    let(:product)   { { :product_id => edit_sale.product.id } }
    let(:supplier)  { { :supplier_id => edit_sale.supplier.id } }

    before(:each)   { patch :update, params: { id: edit_sale.id, sale: { ** new_values.merge(shopper).merge(product).merge(supplier) } } }

    context 'when valid sale' do
      let(:new_values) { attributes_for(:valid_sale) }

      it 'redirect to sales path if the sale was updated' do
        expect(flash[:notice]).to eq('messages.updated')
        expect(response).to redirect_to(sales_path)
      end
    end

    context 'when invalid sale' do
      let(:new_values) { attributes_for(:invalid_sale) }

      it 'renders a edit action if the sale was not updated' do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) { delete :destroy, params: { id: destroy_sale.id } }

    context 'when valid sale' do
      let(:destroy_sale) { sales.sample }

      it 'redirect to sales path if the sale was destroyed' do
        expect(flash[:notice]).to eq('messages.destroyed')
        expect(response).to redirect_to(sales_path)
      end
    end

    context 'when invalid sale' do
      let(:destroy_sale) { build :invalid_sale }

      it 'renders a root path if the sale was not destroyed' do
        expect(flash[:alert]).to eq('messages.error.notfound')
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'POST #upload' do
    before(:each) { post :upload, params: { ** file_upload } }

    context 'when valid file' do
      let(:file_upload) { attributes_for(:valid_file) }

      it 'redirect to sales path if the sale was uploaded' do
        expect(flash[:notice]).to eq('messages.uploaded')
        expect(response).to redirect_to(sales_path)
      end
    end

    context 'when invalid file' do
      let(:file_upload) { attributes_for(:invalid_file) }

      it 'renders a root path if the file was not uploaded' do
        expect(flash[:alert]).to eq('messages.error.typefile')
        expect(response).to redirect_to(root_path)
      end
    end
  end

end
