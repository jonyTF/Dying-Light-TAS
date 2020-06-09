import tkinter as tk
import threading
import datetime

class MyApp(object):
  def __init__(self, parent):
    self.root = parent
    self.root.title('Value update test')
    
  
    self.HealthLabel = tk.Label(text="Health: ")
    self.PlayerXLabel = tk.Label(text="PlayerX: ")
    self.PlayerYLabel = tk.Label(text="PlayerY: ")
    self.PlayerZLabel = tk.Label(text="PlayerZ: ")
    self.HeadXLabel = tk.Label(text="HeadX: ")
    self.HeadYLabel = tk.Label(text="HeadY: ")
    self.HeadZLabel = tk.Label(text="HeadZ: ")
    self.HeadPitchLabel = tk.Label(text="HeadPitch: ")
    self.HeadYawLabel = tk.Label(text="HeadYaw: ")

    self.HealthLabel.pack()
    self.PlayerXLabel.pack()
    self.PlayerYLabel.pack()
    self.PlayerZLabel.pack()
    self.HeadXLabel.pack()
    self.HeadYLabel.pack()
    self.HeadZLabel.pack()
    self.HeadPitchLabel.pack()
    self.HeadYawLabel.pack()

    self.stopped = False

    btn = tk.Button(self.root, text="Run", command=self.startThread)
    btn.pack()

    stopBtn = tk.Button(self.root, text="Stop", command=self.stop)
    stopBtn.pack()

  def run(self):
    while not self.stopped:
      '''
      for name in (
        'Health', 
        'PlayerX', 
        'PlayerY', 
        'PlayerZ', 
        'HeadX', 
        'HeadY',
        'HeadZ',
        'HeadPitch',
        'HeadYaw'
      ):
        with open(f'GameData/{name}.txt', 'r') as f:
          label = eval(f'self.{name}Label')
          label['text'] = f'{name}: {f.read()}'
      '''
      with open(f'GameData/data.txt', 'r') as f:
        lines = f.readlines()

      for line in lines:
        split = line.split(':')
        name = split[0]
        value = split[1].strip()
        label = eval(f'self.{name}Label')
        label['text'] = f'{name}: {value}'

  def startThread(self):
    thread = threading.Thread(target=self.run)
    thread.start()

  def stop(self):
    self.stopped = True

if __name__ == '__main__':
  root = tk.Tk()
  app = MyApp(root)
  root.mainloop()