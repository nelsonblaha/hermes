class InboxesController < ApplicationController
  # GET /inboxes
  # GET /inboxes.json

  # scaffolding methods

    def index
      @inboxes = Inbox.all

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @inboxes }
      end
    end

    # GET /inboxes/1
    # GET /inboxes/1.json
    def show
      @inbox = Inbox.find(params[:id])

      #TODO optimize
      @active_messages = []
      @inbox.messages.each do |m|
        @active_messages << m if !m.resolved
      end

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @inbox }
      end
    end

    # GET /inboxes/new
    # GET /inboxes/new.json
    def new
      @inbox = Inbox.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @inbox }
      end
    end

    # GET /inboxes/1/edit
    def edit
      @inbox = Inbox.find(params[:id])
    end

    # POST /inboxes
    # POST /inboxes.json
    def create
      @inbox = Inbox.new(params[:inbox])
      @inbox.user = current_user

      respond_to do |format|
        if @inbox.save
          format.html { redirect_to root_url, notice: 'Inbox was successfully created.' }
          format.json { render json: @inbox, status: :created, location: @inbox }
        else
          format.html { render action: "new" }
          format.json { render json: @inbox.errors, status: :unprocessable_entity }
        end
      end
    end

    # PUT /inboxes/1
    # PUT /inboxes/1.json
    def update
      @inbox = Inbox.find(params[:id])

      respond_to do |format|
        if @inbox.update_attributes(params[:inbox])
          format.html { redirect_to root_url, notice: 'Inbox was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @inbox.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /inboxes/1
    # DELETE /inboxes/1.json
    def destroy
      @inbox = Inbox.find(params[:id])
      @inbox.destroy

      respond_to do |format|
        format.html { redirect_to root_url, notice:'Inbox Destroyed' }
        format.json { head :no_content }
      end
    end

  def resolve_all_messages
    @inbox = Inbox.find(params[:id])

    @inbox.messages.each do |message|
      message.resolved = true
      message.save
    end 

    @inbox.presentations.where(rule_id:nil).destroy_all

    redirect_to @inbox
  end

  def check_for_messages
    @inbox = Inbox.find(params[:id])

    @inbox.user.message_sources
  end

end
