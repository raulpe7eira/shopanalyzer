require 'rails_helper'

RSpec.describe ShoppersController, :type => :controller do

  login_user

  let(:shoppers) { create_list :valid_shopper, 4, user: subject.current_user }

  describe 'GET #index' do
    before(:each) { get :index }

    it 'responds successfully with an HTTP 200 status code' do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end

    it 'loads all shoppers into the @shoppers' do
      expect(assigns(:shoppers)).to match_array(shoppers)
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

    it 'instantiates a new shopper' do
      shopper = assigns(:shopper)

      expect(shopper).to be_kind_of ActiveRecord::Base
      expect(shopper).not_to be_persisted
      expect(shopper.user).to eq(subject.current_user)

      expect(shoppers).not_to include(shopper)
    end
  end

  describe 'GET #edit' do
    let(:edit_shopper) { shoppers.sample }

    before(:each) { get :edit, params: { id: edit_shopper.id } }

    it 'responds successfully with an HTTP 200 status code' do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders the edit template' do
      expect(response).to render_template(:edit)
    end

    it 'instantiates a edit shopper' do
      shopper = assigns(:shopper)

      expect(shopper).to be_kind_of(ActiveRecord::Base)
      expect(shopper).to be_persisted
      expect(shopper.user).to eq(subject.current_user)
      expect(shopper).to eq(edit_shopper)
    end
  end

  describe 'POST #create' do
    before(:each) { post :create, params: { shopper: { ** new_shopper } } }

    context 'when valid shopper' do
      let(:new_shopper) { attributes_for(:valid_shopper) }

      it 'redirect to shoppers path if the shopper was created' do
        expect(flash[:notice]).to eq('messages.created')
        expect(response).to redirect_to(shoppers_path)
      end
    end

    context 'when invalid shopper' do
      let(:new_shopper) { attributes_for(:invalid_shopper) }

      it 'renders a new action if the shopper was not created' do
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH/PUT #update' do
    let(:edit_shopper) { shoppers.sample }

    before(:each) { patch :update, params: { id: edit_shopper.id, shopper: { ** new_values } } }

    context 'when valid shopper' do
      let(:new_values) { attributes_for(:valid_shopper) }

      it 'redirect to shoppers path if the shopper was updated' do
        expect(flash[:notice]).to eq('messages.updated')
        expect(response).to redirect_to(shoppers_path)
      end
    end

    context 'when invalid shopper' do
      let(:new_values) { attributes_for(:invalid_shopper) }

      it 'renders a edit action if the shopper was not updated' do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) { delete :destroy, params: { id: destroy_shopper.id } }

    context 'when valid shopper' do
      let(:destroy_shopper) { shoppers.sample }

      it 'redirect to shoppers path if the shopper was destroyed' do
        expect(flash[:notice]).to eq('messages.destroyed')
        expect(response).to redirect_to(shoppers_path)
      end
    end

    context 'when invalid shopper' do
      let(:destroy_shopper) { build :invalid_shopper }

      it 'renders a root path if the shopper was not destroyed' do
        expect(flash[:alert]).to eq('messages.error.notfound')
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when shopper has dependents' do
      let(:sales) { create_list :valid_sale, 1, user: subject.current_user }
      let(:destroy_shopper) { sales.sample.shopper }

      it 'renders a root path if the shopper was not destroyed' do
        expect(flash[:alert]).to eq('messages.error.dependents')
        expect(response).to redirect_to(root_path)
      end
    end
  end

end
