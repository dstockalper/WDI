
# EXERCISE CODE

class Person

    # initialize() is a Constructor:
    # Its arguments are whatever get passeed to Person.new()

    def initialize(name)
        @name = name

        # The lists are initialized to empty Arrays.
        @friends = Array.new()
        @pets = Array.new()
    end

    def meet_friend(friend)
        @friends.push(friend)
    end

    def meet_pet(pet)
        @pets.push(pet)
    end

    # to_s(): We can control how Ruby represents our object when printed as a
    # string.  (Yup, this is the same to_s() we have been calling all along!)

    def to_s()
        return @name
    end

    # Getters

    def name()
        return @name
    end

    def friends()
        return @friends
    end

    def pets()
        return @pets
    end

end


class PopularityContest

    def initialize(people)
        @people = people
        @popularity = Hash.new()

        # Initialize the popularity hash with everyone's names, and their
        # popularity set to zero. (It will be calculated in the next method.)
        people.each do |person|
            @popularity[person.name] = 0
        end
    end

    # This must be called before sorted_by_popularity() to calculate the actual
    # popularity data.

    def calculate()
        # For each person...
        @people.each do |person|
            # Look at each of their friends...
            person.friends.each do |friend|
                # And increment that friend's popularity.
                @popularity[friend.name] += 1
            end
        end
    end

    def sorted_by_popularity()
        # The sort() docs say:

        # The block must implement a comparison between a and b, and return
        # -1, when a follows b, 0 when a and b are equivalent, or +1 if b
        # follows a.

        @people.sort do |a, b|
            if @popularity[a.name] > @popularity[b.name]
                # This means a is MORE popular than b
                -1
            elsif @popularity[a.name] == @popularity[b.name]
                # This means they're equally popular
                0
            elsif @popularity[a.name] < @popularity[b.name]
                # This means a is LESS popular than b
                1
            end
        end
    end

end



class Cat

    def initialize(name)
        @name = name
    end

    def name()
        return @name
    end

    def to_s()
        return @name + " the Cat"
    end

end


# TEST CODE (to help prove that the exercises are solved)

class CodeTester

    # A simple utility class for running code for each exercise.

    # All of the exercises will use the same data, so they will all inherit
    # from this class and use its initialize() function.

    def initialize()
        @bella = Person.new('Bella')
        @gordo = Person.new('Gordo')
        @lara = Person.new('Lara')
        @celeste = Person.new('Celeste')

        @jinx = Cat.new('Jinx')
        @horton = Cat.new('Horton')

        @people = [@bella, @gordo, @lara, @celeste]
    end

end

class TestMeetAndGetFriends < CodeTester

    TITLE = "Exercises 1.1 and 1.2"

    def run()
        @bella.meet_friend(@gordo)
        @bella.meet_friend(@jinx)
        STDOUT.puts("Bella's friends:")
        STDOUT.puts(@bella.friends())
    end

end

class TestMeetAndGetPets < CodeTester

    TITLE = "Exercises 1.3 and 1.4"

    def run()
        @gordo.meet_pet(@horton)
        @gordo.meet_pet(@jinx)
        STDOUT.puts("Gordo's pets:")
        STDOUT.puts(@gordo.pets())
    end

end

class TestSortByPopularity < CodeTester

    TITLE = "Exercise 2"

    def run()
        @bella.meet_friend(@gordo)
        @lara.meet_friend(@gordo)
        @celeste.meet_friend(@gordo)

        @lara.meet_friend(@bella)
        @celeste.meet_friend(@bella)

        @gordo.meet_friend(@lara)

        contest = PopularityContest.new(@people)
        contest.calculate()
        sorted_people = contest.sorted_by_popularity()

        STDOUT.puts("Sorted by popularity:")
        STDOUT.puts("(Should be Gordo, Bella, Lara, Celeste)")
        STDOUT.puts(sorted_people)
    end

end


# Iterate through all the tester classes.
# For each one...
[
    TestMeetAndGetFriends,
    TestMeetAndGetPets,
    TestSortByPopularity
].each do |test_class|
    # Note that test_class here is a regular variable, but it is referring
    # to a class!!!

    # Print some breathing room...
    STDOUT.puts()

    # Print its TITLE constant in uppercase...
    STDOUT.puts(test_class::TITLE.upcase())

    # Instantiate it to populate the test data...
    # (This will invoke the instantiate() defined in CodeTester)
    tester = test_class.new()

    # And run it
    # (This will invoke the run() defined by the subclass itself)
    tester.run()
end
