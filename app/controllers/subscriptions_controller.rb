class SubscriptionsController < ApplicationController
    before_action :authenticate_user!

    def create
        @subscription = current_user.subscriptions.new(subscription_params)
        if @subscription.save
            respond_to do |format|
                format.html { redirect_back(fallback_location: root_path, notice: "Subscription successful") }
                format.turbo_stream { flash.now[:notice] = 'Subscribed' }
            end
        else
            flash[:notice] = @subsubscription.errors.full_messages.to_sentence
        end
    end

    def destroy
        @subscription = current_user.subscriptions.find(params[:id])
        subscribable = @subscription.subscribable
        @subscription.destroy
        respond_to do |format|
            format.html { format.html { redirect_back(fallback_location: root_path, notice: "Unsubscribed") } }
            format.turbo_stream { flash.now[:notice] = 'Subscription removed' }
        end
    end

    private

        def subscription_params
            params.require(:subscription).permit(:subscribable_id, :subscribable_type)
        end

        def subscribable
            @subscribable ||= Subscribable.find(params[:subscribable_id])
        end
end
