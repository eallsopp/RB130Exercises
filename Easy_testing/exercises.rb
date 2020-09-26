require 'minitest/autorun'

#assert
class TestExercises < MiniTest::Test
  def test_odd?
    assert(value.odd? 'the value is not odd')
  end
  
  #equality assertions
  def test_downcase
    test_equal('xyz', value.downcase)
  end
  #nil
  def test_nil
    assert_nil?(value)
  end
  #empty?
  def test_emply_object
    assert_empty(list)
  end
  #includes
  def test_include
    assert_includes(list, 'xyz')
  end
  #error/exemption
  def test_exemptions
    assert_raises(NoExperienceError) {employee.hire}
  end
  #type
  def test_type
    assert_instance_of(Numeric, value)
  end
  #kind of
  def test_kind
    assert_kind_of(Numeric, value)
  end
  #same obj
  def test_same
    assert_same(list, list.process)
  end
  #refutation
  def test_refutation
    refute_includes(list, 'xyz')
  end
end