fn main() raises:
    try:
      var  f = open("requirements.txt", "r")
      print(f.read())
      f.close()
    except:
        print("Error opening file: {e}")
