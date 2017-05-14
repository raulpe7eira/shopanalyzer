require 'rails_helper'

RSpec.describe ProductsController, :type => :controller do

  login_user

  let(:products) { create_list :valid_product, 4, user: subject.current_user }

  describe 'GET #index' do
    before(:each) { get :index }

    it 'responds successfully with an HTTP 200 status code' do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end

    it 'loads all products into the @products' do
      expect(assigns(:products)).to match_array(products)
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

    it 'instantiates a new product' do
      product = assigns(:product)

      expect(product).to be_kind_of ActiveRecord::Base
      expect(product).not_to be_persisted
      expect(product.user).to eq(subject.current_user)

      expect(products).not_to include(product)
    end
  end

  describe 'GET #edit' do
    let(:edit_product) { products.sample }

    before(:each) { get :edit, params: { id: edit_product.id } }

    it 'responds successfully with an HTTP 200 status code' do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders the edit template' do
      expect(response).to render_template(:edit)
    end

    it 'instantiates a edit product' do
      product = assigns(:product)

      expect(product).to be_kind_of(ActiveRecord::Base)
      expect(product).to be_persisted
      expect(product.user).to eq(subject.current_user)
      expect(product).to eq(edit_product)
    end
  end

  describe 'POST #create' do
    before(:each) { post :create, params: { product: { ** new_product } } }

    context 'when valid product' do
      let(:new_product) { attributes_for(:valid_product) }

      it 'redirect to products path if the product was created' do
        expect(flash[:notice]).to eq('messages.created')
        expect(response).to redirect_to(products_path)
      end
    end

    context 'when invalid product' do
      let(:new_product) { attributes_for(:invalid_product) }

      it 'renders a new action if the product was not created' do
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH/PUT #update' do
    let(:edit_product) { products.sample }

    before(:each) { patch :update, params: { id: edit_product.id, product: { ** new_values } } }

    context 'when valid product' do
      let(:new_values) { attributes_for(:valid_product) }

      it 'redirect to products path if the product was updated' do
        expect(flash[:notice]).to eq('messages.updated')
        expect(response).to redirect_to(products_path)
      end
    end

    context 'when invalid product' do
      let(:new_values) { attributes_for(:invalid_product) }

      it 'renders a edit action if the product was not updated' do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) { delete :destroy, params: { id: destroy_product.id } }

    context 'when valid product' do
      let(:destroy_product) { products.sample }

      it 'redirect to products path if the product was destroyed' do
        expect(flash[:notice]).to eq('messages.destroyed')
        expect(response).to redirect_to(products_path)
      end
    end

    context 'when invalid product' do
      let(:destroy_product) { build :invalid_product }

      it 'renders a root path if the product was not destroyed' do
        expect(flash[:alert]).to eq('messages.error.notfound')
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when product has dependents' do
      let(:sales) { create_list :valid_sale, 1, user: subject.current_user }
      let(:destroy_product) { sales.sample.product }

      it 'renders a root path if the product was not destroyed' do
        expect(flash[:alert]).to eq('messages.error.dependents')
        expect(response).to redirect_to(root_path)
      end
    end
  end

end
