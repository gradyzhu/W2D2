
class Employee
    attr_reader :name, :title, :salary, :boss

    def initialize(name, title, salary, boss)
        @name = name
        @title = title
        @salary = salary
        @boss = boss
    end

    def bonus(multiplier)
        salary * multiplier
    end
end

class Manager < Employee
    attr_reader :assigned

    def initialize(name, title, salary, boss)
        super
        @assigned = []
    end

    def add_employee(employee)
        @assigned << employee
    end

    def bonus(multiplier)
        total_salary * multiplier
    end

    def total_salary
        sum = 0
        @assigned.each do |employee|
            if employee.is_a?(Manager)
                sum += employee.total_salary #if manager, then you also get employees salaries added
            end
            sum += employee.salary #manager || employee added no matter what.
        end
        sum
    end

end

ned = Manager.new("Ned", "Founder", 1000000, nil)
darren = Manager.new("Darren", "TA Manager", 78000, ned)
shawna = Employee.new("Shawna", "TA", 12000, darren)
david = Employee.new("David", "TA", 10000, darren)
ned.add_employee(darren)
darren.add_employee(shawna)
darren.add_employee(david)
puts ned.bonus(5)
puts darren.bonus(4)
puts david.bonus(3)
