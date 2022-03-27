class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[ edit update destroy ]
  before_action :set_finished

  # GET /reservations or /reservations.json
  def index
    @reservations = Reservation.active_reservations
  end

  # # GET /reservations/1 or /reservations/1.json

  # GET /reservations/new
  def new
    @reservation = Reservation.new
  end

  # GET /reservations/1/edit
  def edit
    @edit = false
  end

  # POST /reservations or /reservations.json
  def create
    @reservation = Reservation.new(reservation_params)

    respond_to do |format|
      if @reservation.save
        format.html { redirect_to edit_reservation_path(@reservation), notice: "Reservation was successfully created." }
        format.json { render :edit, status: :created, location: @reservation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservations/1 or /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to edit_reservation_path(@reservation), notice: "Reservation was successfully updated." }
        format.json { render :edit, status: :ok, location: @reservation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1 or /reservations/1.json
  def destroy
    @reservation.destroy

    respond_to do |format|
      format.html { redirect_to reservations_url, notice: "Reservation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def filter_reservations
    filter = params[:filter].to_i
    if (filter.nil? || filter == 0)
      return
    end
    @reservations = Reservation.active_reservations
    case filter
    when 1
      @reservations = @reservations.joins(:room).merge(Room.order(:name))
    when 2
      @reservations = @reservations.order(:subject)
    when 3
      @reservations = @reservations.order(:t_beginning)
    when 4
      @reservations = @reservations.joins(:room).merge(Room.order(name: :desc))
    when 5
      @reservations = @reservations.order(subject: :desc)
    when 6
      @reservations = @reservations.order(t_beginning: :desc)
    end
  end

  private
  def set_finished
    Reservation.active_reservations.each do |r|
      if (r.t_beginning < DateTime.now && r.t_ending < DateTime.now)
        r.update(finished: true)
        if not r.save
          p "*" * 100
          puts r.errors.full_messages
          p "*" * 100
        end
      end
    end
  end
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reservation_params
      params.require(:reservation).permit(:room_id, :t_beginning, :t_ending, :attendees, :subject, :reservation_code, :email)
    end
end
