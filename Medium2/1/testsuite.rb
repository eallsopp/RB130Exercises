require 'minitest/autorun'
require_relative 'cashregister'
require_relative 'transaction'

class CashRegisterTest < Minitest::Test
  
  def setup
    @register = CashRegister.new(100)
    @transaction = Transaction.new(20)
    
  end
  
  def test_accept_money
    previous_amount = @register.total_money
    @transaction.amount_paid = 25
    @register.accept_money(@transaction)
    current_amount = @register.total_money
    
    assert_equal(previous_amount + @transaction.amount_paid, current_amount)
  end
  
  def test_change
    @transaction.amount_paid = 50
    change_given = @register.change(@transaction)
    assert_equal(30, change_given)
  end
  
  def test_receipt
    assert_output("You've paid $#{@transaction.item_cost}.\n") do 
      @register.give_receipt(@transaction) 
    end
  end
  
  def test_prompt_for_payment
    input = StringIO.new('30\n')
    output = StringIO.new
    @transaction.prompt_for_payment(input: input, output: output)
    assert_equal(30, @transaction.amount_paid)
  end
  
  
end