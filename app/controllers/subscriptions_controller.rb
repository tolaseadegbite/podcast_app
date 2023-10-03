class SubscriptionsController < ApplicationController
    before_action :authenticate_user!
    # before_action :restrict_current_user_channel_subscription, only: :create

    def create
        @subscription = current_user.subscriptions.new(subscription_params)
        if @subscription.save
            respond_to do |format|
                format.html { redirect_back(fallback_location: subscription.subscribable, notice: "Subscription successful") }
                format.turbo_stream { flash.now[:notice] = 'Subscribed' }
            end
        else
            flash[:notice] = @subscription.errors.full_messages.to_sentence
        end
    end

    def destroy
        @subscription = current_user.subscriptions.find(params[:id])
        subscribable = @subscription.subscribable
        @subscription.destroy
        respond_to do |format|
            format.html { redirect_back(fallback_location: subscription.subscribable, notice: "Unsubscribed") }
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

        # current user can't subscribe to their channels
        def restrict_current_user_channel_subscription
            redirect_back(fallback_location: @subscription.subscribable, status: :see_other, notice: "You can't subscribe to ypur channels") if params[:user_id].to_i == current_user.id
        end
end
