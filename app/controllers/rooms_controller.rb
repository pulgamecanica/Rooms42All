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
        format.json { render :show, status: :ok, location: @room }
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


  def create_array (find_min_cap, start_date, end_date, min_capacity)
    list = []
    find_min_cap.each do |room|
      res = room.reservations.build(t_beginning: start_date, t_ending: end_date)
      res.attendees = min_capacity
      res.t_beginning = start_date
      res.t_ending = end_date
      list.push([room, res])
    end
    list
  end

  def search_rooms
    start_date = params[:start_date].to_datetime
    end_date = params[:end_date].to_datetime
    min_capacity = params[:capacity].to_i # to_i = to integer (becausse we are recieving a string....)
    need_handicap_access = params[:is_accessible].nil? == true ? false : true
    need_projector = params[:need_projector].nil? == true ? false : true
    need_audio = params[:audio_system].nil? == true ? false : true
    need_desk = params[:had_desk].nil? == true ? false : true
    if end_date.nil? || start_date.nil?
      @error = "Choose a date"
      return nil
    elsif min_capacity <= 0
      @error = "Capacity must be > 0"
      return nil
    elsif start_date >= end_date
      @error = "Wrong dates"
      return nil
    end

    accessible_rooms = Room.free_schedule(start_date, end_date).where(is_available: true).where(is_accessible: true).where(capacity: min_capacity..)
    accessible_rooms = accessible_rooms.order(:capacity)
    not_accessible_rooms = Room.free_schedule(start_date, end_date).where(is_available: true).where(is_accessible: false).where(capacity: min_capacity..)
    not_accessible_rooms = not_accessible_rooms.order(:capacity)
    if need_projector
      accessible_rooms = accessible_rooms.where(has_projector: true)
      not_accessible_rooms = not_accessible_rooms.where(has_projector: true)
    end
    if need_audio
      accessible_rooms = accessible_rooms.where(audio_system: true)
      not_accessible_rooms = not_accessible_rooms.where(audio_system: true)
    end
    if need_desk
      accessible_rooms = accessible_rooms.where(had_desk: true)
      not_accessible_rooms = not_accessible_rooms.where(had_desk: true)
    end
    if (need_handicap_access)
      find_min_cap = accessible_rooms + not_accessible_rooms
    else
      find_min_cap = not_accessible_rooms + accessible_rooms
    end
    @rooms = create_array(find_min_cap, start_date, end_date, min_capacity)
  end

  private

    def set_reservations_finished
      Reservation.all.active_reservations.each do |x|
        if (x.t_ending <= DateTime.now || x.finished == true)
          x.delete
        end
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def room_params
      params.require(:room).permit(:capacity, :is_available, :name, :location, :is_accessible, :has_projector, :audio_system, :had_desk)
    end
end
