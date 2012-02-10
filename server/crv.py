#!/bin/env python
import pickle

class crv_session:

  def __init__(self,fromfile='',file='',state='',node='',display='',jobid='',sessionid='',username=''):
    if (fromfile != ''):
      self.hash=pickle.load(fromfile)
    else:
      self.hash={'file':file, 'state':state, 'node':node, 'display':display, 'jobid':jobid, 'sessionid':sessionid, 'username':username}

  def set(self,key,val):
    self.hash[key]=val

  def get(self,key):
    return(self.hash[key])

  def serialize(self,file):
    pickle.dump(self.hash, open( file, "wb" ) )

  def write(self,format=0):
    if ( format == 1):
      for k in sort(keys(self.hash)):
        print "%s:%s\n" % ( k , self.hash[k] )
    else:
      pickle.dumps(self.hash)


class crv_sessions:

  def __init__(self,fromfile='',sessions=[]):
    if (fromfile != ''):
      self.array=pickle.load(fromfile)
    else:
      self.array=sessions

  def serialize(self,file):
    pickle.dump(self.array, open( file, "wb" ) )

  def write(self,format=0):
    if ( format == 1):
      for k in self.array:
        k.write(1)
    else:
      pickle.dumps(self.array)

 
