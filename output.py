from engine import *

#PRIMITIVE:
Somename = 0
Someothername = 1
difficulty = 1
fg_color = 1
bg_color = 5
speed_increase_factor = 1
speed_decrease_factor = 1
difficulty = 1
show_next = 0

#FUNCTIONS:
def mainFunc():
    global show_next
    show_next = 1


#ENGINE:
if __name__ == '__main__':
	mainFunc()
	tetris_engine = TetrisEngine(difficulty = difficulty, fg = fg_color, show_next = show_next)


