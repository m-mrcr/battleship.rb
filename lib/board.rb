require './lib/cell'
class Board

  attr_reader :cells,
              :letter_coordinates,
              :number_coordinates

  def initialize
    @cells = Hash.new
    create_cells
  end

  def create_cells
    letter_coordinates = ("A".."D").to_a
    number_coordinates = (1..4).to_a

      letter_coordinates.each do |letter|

        number_coordinates.each do |number|
          coordinate = "#{letter}#{number}"
          @cells[coordinate] = Cell.new(coordinate)
        end
      end
  @cells
  end

  def valid_coordinate?(coordinate)
    cells.has_key?(coordinate)
  end

  def get_orientation(coordinates)
    letters = coordinates.map do |coordinate|
      coordinate[0]
    end
    numbers = coordinates.map do |coordinate|
      coordinate[1]
    end


    if letters.all? {|letter| letter == letters[0] }
      return :horizontal

    elsif numbers.all? {|number| number == numbers[0] }
      return :vertical
    end

  end


  def valid_placement?(ship, coordinates)
    letters = coordinates.map do |coordinate|
      coordinate[0].ord
    end
    numbers = coordinates.map do |coordinate|
      coordinate[1].to_i
    end


    if ship.length != coordinates.length
      return false
    end

    if coordinates.any? do |coordinate|
      @cells[coordinate].ship != nil
      end
      return false
    end

    orientation = get_orientation(coordinates)

    if orientation == :horizontal
       numbers.each_cons(2) do |first, second|
           if second != first + 1
             return false
           end
         end

         return true

    elsif orientation == :vertical
      letters.each_cons(2) do |first, second|
          if second != first + 1
            return false
          end
        end

        return true

    else
      return false
    end
  end


def place(ship, coordinates)

  if valid_placement?(ship, coordinates)

    coordinates.each do |coordinate|
      @cells[coordinate].place_ship(ship)
    end

  else
    "You can't put a ship here."
  end
end


  def render(show_ships = false)

      "  1 2 3 4 \n" +
      "A #{@cells["A1"].render} . . . \n" +
      "B . . . . \n" +
      "C . . . . \n" +
      "D . . . . \n"

  end

end
