class RoomsController < ApplicationController
  before_action :set_room, only: %i[ edit update destroy ] 

  # GET /rooms or /rooms.json
  def index
    @page = params.fetch(:page, 0).to_i
    if ((@page + 1) * 5) >= Room.count
      @rooms = Room.last(5)
      @last = true
    else
      @rooms = Room.all.offset(@page * 5).limit(5)
      @last = false
    end
  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
    @new_reservation = @room.reservations.build(room: @room)
  end

  # POST /rooms or /rooms.json
  def create
    @room = Room.new(room_params)

    respond_to do |format|
      if @room.save
        format.html { redirect_to edit_room_path(@room), notice: "Room was successfully created." }
        format.json { render :edit, status: :created, location: @room }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1 or /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to edit_room_path(@room), notice: "Room was successfully updated." }
        format.json { render :edit, status: :ok, location: @room }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1 or /rooms/1.json
  def destroy
    @room.destroy

    respond_to do |format|
      format.html { redirect_to rooms_url, notice: "Room was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def search_rooms
    ranking = {}
    start_date = params[:start_date].to_date
    end_date = params[:end_date].to_date
    min_capacity = params[:capacity].to_i # to_i = to integer (becausse we are recieving a string....)
    need_handicap_access = params[:is_accessible].nil? == true ? false : true

    if min_capacity <= 0
      return
    end
    if end_date < start_date
      #format.json { render json: @room.errors, status: :unprocessable_entity }
      return
    end
    # Filter All rooms that are available AT ALL TIME BETWEEN START AND END
    find_min_cap = Room.where(is_available: true) # .and(Room.where(capacity: min_capacity - 2..min_capacity + 2))
    find_min_cap.each do |room|
      ranking.store(room, (min_capacity - room.capacity).abs)
    end
    puts "*" * 10
    puts ranking.sort
    puts "*" * 10
    find_min_cap
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    def check_filter_parameters
      if params[:capacity].nil?
          #throw error

      end
    end
    # Only allow a list of trusted parameters through.
    def room_params
      params.require(:room).permit(:capacity, :is_available, :name, :location, :is_accessible)
    end
end
