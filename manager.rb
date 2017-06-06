class Employee
  attr_accessor :boss
  attr_reader :salary, :name
  def initialize(name, title, salary, boss)
    @name, @title, @salary  = name, title, salary
    @boss = boss
    boss.add_employee(self) unless boss.nil?
  end


  def bonus(multiplier)
    bonus = @salary * multiplier
  end

end

class Manager < Employee
  attr_reader :salary, :name, :employees
  def initialize(name, title, salary, boss=nil)
    @employees = []
    super
  end

  def add_employee(employee)
    @employees << employee unless @employees.include?(employee)
    # employee.boss=self unless employee.boss == self
  end

  def bonus(multiplier)
    queue = @employees.dup
    # p @employees[0].employees(&:name)
    queue.each do |workers|
      if workers.is_a?(Manager)
        queue.concat(workers.employees) #unless workers.is_a?(Employee)
      else
        queue.concat([workers]) unless queue.include?(workers)
      end
    end
    # p queue.map(&:name)
    total_salary = 0
    queue.each do |workers|
      total_salary += workers.salary
    end
    bonus = total_salary * multiplier
  end
end

ned = Manager.new('Ned', 'Founder', 100000)
darren = Manager.new('Darren', 'TA Manager', 78000, ned)
david = Employee.new('David', 'TA', 10000, darren)
shawna = Employee.new('Shawna', 'TA', 12000, darren)

# p david.bonus(3)
# p darren.bonus(4)
p ned.bonus(5)
