require 'ray'

# Prerequisites:
# brew install glew libsndfile gcc freetype

# Tutorial:
# http://mon-ouie.github.io/projects/ray.html

quit_game = Proc.new() do
    # This method doesn't exist yet. It is defined inside Ray, but since the
    # quit_game Proc doesn't run until Ray is setup, it doesn't matter!
    exit!
end

game = Ray.game('Hello') do

    # We have to make this into a block because it must be run
    # every time the scene changes
    register() do

       add_hook(:quit, quit_game)
       add_hook(:key_press, key(:q), quit_game)
       @sound = sound "piano_G6.wav"


       on(:mouse_press) do |button, pos|
           STDOUT.puts("User clicked " + button.to_s() + " at " + pos.to_s() + ".")
           @sound.play
       end

    end

    scene(:hello) do
        @text = text("Hello, world!", {:size => 50, :at => [50, 50]})

        @obj = Ray::Polygon.rectangle([-50, -50, 100, 100], Ray::Color.blue())
        @obj.pos = [100, 350] # starting position

        on(:mouse_motion) do |pos|
            Kernel.puts pos.x
            @obj.pos = pos
            @obj.color = Ray::Color.new(pos.x, pos.y,0)

        end

        render() do |window|
            window.draw(@text)
            window.draw(@obj)
        end
    end

    scenes.push(:hello)

end