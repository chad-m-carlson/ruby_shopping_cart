@cart = []
@hash = @cart.map { |item, price| { item: item, price: price } }
def menu
  puts "Please make a selection"
  puts "1) Add items to cart"
  puts "2) View items in your cart"
  puts "3) View your total"
  puts "4) Remove items from your cart"
  puts "5) Place your order"
  puts "6) Exit"
end

def user_selection
  menu
  choice = gets.to_i
  case choice
  when 1
    add_to_cart
  when 2
    view_cart
  when 3
    total
  when 4
    remove_from_cart
  when 5
    place_order
  when 6
    exit  
  end
  user_selection
end

def add_to_cart
  puts "What item would you like to add to your cart?"
  items = gets.strip
  @cart << [items, "#{rand(1.0..10.0).round(2)}".to_f]
  seperator
end

def view_cart
  if @cart.length == 0
    puts "Your cart is empty"
  else
    puts @cart.map { |item, price| { item: item, price: price } }
  end
  seperator
end

def total
  new_cart = @cart.map { |item, price| { item: item, price: price } }
  total = new_cart.map { |x| x.values[1] }.reduce(:+)
  if total == nil
    puts "Your cart is empty"
  else
    puts "Your current total is $#{total}"
  end
  seperator
end

def remove_from_cart
  puts "Select an item to remove from your cart. Type 'exit' to exit"
  items = print_shopping_list(@cart)
  choice = gets.to_i
  print_shopping_list(@cart)
  if choice > 0 && choice <= items.length
    item = items[choice -1]
  elsif choice == "exit"
     user_selection
  else
    puts "Invalid Choice"
    remove_from_cart
  end
  @cart.slice!(choice - 1)
  seperator
end

def print_shopping_list(list)
  list.each_with_index { |item, index| puts "#{index+1} #{item}"}
end

def place_order
  if @cart.length == 0
    puts "There is nothing in your cart"
    seperator
    user_selection
  end
  puts "Please enter your 9 digit credit card number"
  card_number = gets.strip.to_s
  if card_number.length == 9
    total = @cart.map { |x| x[1] }.reduce(:+)
    puts "Your total is #{total} and has been charged to your credit card ending in #{card_number[5..9]}."
    @cart = []
  else
    puts "Invalid card number"
    place_order
  end
  seperator
end

def seperator
  puts "*" * 10
  puts
end

user_selection