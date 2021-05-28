#!/usr/bin/env python
# coding: utf-8

# In[4]:


from flask_restful import Resource
from flask import Flask, request

class HelloWorld(Resource):
    def get(self):
        obj_type = request.args.get('type', "")
        
        return {obj_type: 'world'}

