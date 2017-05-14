require 'rails_helper'

RSpec.describe 'Routes', :type => :routing do

  describe '#devises' do
    context 'sessions for users' do
      it { should route(:get, '/users/sign_in').to(:controller => :'devise/sessions', :action => :new) }
      it { should route(:post, '/users/sign_in').to(:controller => :'devise/sessions', :action => :create) }
      it { should route(:delete, '/users/sign_out').to(:controller => :'devise/sessions', :action => :destroy) }
    end

    context 'passwords for users' do
      it { should route(:get, '/users/password/new').to(:controller => :'devise/passwords', :action => :new) }
      it { should route(:get, '/users/password/edit').to(:controller => :'devise/passwords', :action => :edit) }
      it { should route(:patch, '/users/password').to(:controller => :'devise/passwords', :action => :update) }
      it { should route(:put, '/users/password').to(:controller => :'devise/passwords', :action => :update) }
      it { should route(:post, '/users/password').to(:controller => :'devise/passwords', :action => :create) }
    end

    context 'registrations for users' do
      it { should route(:get, '/users/cancel').to(:controller => :'devise/registrations', :action => :cancel) }
      it { should route(:get, '/users/sign_up').to(:controller => :'devise/registrations', :action => :new) }
      it { should route(:get, '/users/edit').to(:controller => :'devise/registrations', :action => :edit) }
      it { should route(:patch, '/users').to(:controller => :'devise/registrations', :action => :update) }
      it { should route(:put, '/users').to(:controller => :'devise/registrations', :action => :update) }
      it { should route(:delete, '/users').to(:controller => :'devise/registrations', :action => :destroy) }
      it { should route(:post, '/users').to(:controller => :'devise/registrations', :action => :create) }
    end
  end

  describe '#resources' do
    context 'for sales' do
      it { should route(:get, '/sales').to(:controller => :sales, :action => :index) }
      it { should route(:get, '/sales/new').to(:controller => :sales, :action => :new) }
      it { should route(:get, '/sales/1/edit').to(:controller => :sales, :action => :edit, :id => 1) }
      it { should route(:post, '/sales').to(:controller => :sales, :action => :create) }
      it { should route(:patch, '/sales/1').to(:controller => :sales, :action => :update, :id => 1) }
      it { should route(:put, '/sales/1').to(:controller => :sales, :action => :update, :id => 1) }
      it { should route(:delete, '/sales/1').to(:controller => :sales, :action => :destroy, :id => 1) }
      it { should route(:get, '/sales/import').to(:controller => :sales, :action => :import) }
      it { should route(:post, '/sales/upload').to(:controller => :sales, :action => :upload) }
    end

    context 'for shoppers' do
      it { should route(:get, '/shoppers').to(:controller => :shoppers, :action => :index) }
      it { should route(:get, '/shoppers/new').to(:controller => :shoppers, :action => :new) }
      it { should route(:get, '/shoppers/1/edit').to(:controller => :shoppers, :action => :edit, :id => 1) }
      it { should route(:post, '/shoppers').to(:controller => :shoppers, :action => :create) }
      it { should route(:patch, '/shoppers/1').to(:controller => :shoppers, :action => :update, :id => 1) }
      it { should route(:put, '/shoppers/1').to(:controller => :shoppers, :action => :update, :id => 1) }
      it { should route(:delete, '/shoppers/1').to(:controller => :shoppers, :action => :destroy, :id => 1) }
    end

    context 'for products' do
      it { should route(:get, '/products').to(:controller => :products, :action => :index) }
      it { should route(:get, '/products/new').to(:controller => :products, :action => :new) }
      it { should route(:get, '/products/1/edit').to(:controller => :products, :action => :edit, :id => 1) }
      it { should route(:post, '/products').to(:controller => :products, :action => :create) }
      it { should route(:patch, '/products/1').to(:controller => :products, :action => :update, :id => 1) }
      it { should route(:put, '/products/1').to(:controller => :products, :action => :update, :id => 1) }
      it { should route(:delete, '/products/1').to(:controller => :products, :action => :destroy, :id => 1) }
    end

    context 'for suppliers' do
      it { should route(:get, '/suppliers').to(:controller => :suppliers, :action => :index) }
      it { should route(:get, '/suppliers/new').to(:controller => :suppliers, :action => :new) }
      it { should route(:get, '/suppliers/1/edit').to(:controller => :suppliers, :action => :edit, :id => 1) }
      it { should route(:post, '/suppliers').to(:controller => :suppliers, :action => :create) }
      it { should route(:patch, '/suppliers/1').to(:controller => :suppliers, :action => :update, :id => 1) }
      it { should route(:put, '/suppliers/1').to(:controller => :suppliers, :action => :update, :id => 1) }
      it { should route(:delete, '/suppliers/1').to(:controller => :suppliers, :action => :destroy, :id => 1) }
    end
  end

  describe 'root' do
    it { expect(get: '/').to route_to(:controller => 'sales', :action => 'index') }
  end

end
