from flask import *

from src.dbconnectionnew import *

app=Flask(__name__)
app.secret_key='qwer'

@app.route('/')
def login():
    return render_template('login.html')

@app.route('/log',methods=['post'])
def log():
    uname=request.form['textfield']
    psw=request.form['textfield2']
    qry="SELECT * FROM `login` WHERE `username`=%s AND `password`=%s"
    val=(uname,psw)
    res=selectone(qry,val)
    if res is None:
        return '''<script>alert('Invalid username or password');window.location='/'</script>'''
    elif res['type']=='admin':
        return '''<script>alert('Welcome admin');window.location='/adminhome'</script>'''
    elif res['type']=='bus':
        session['lid']=res['login_id']
        return '''<script>alert('Welcome bus');window.location='/bushome'</script>'''
    else:
        return '''<script>alert('Invalid');window.location='/'</script>'''


#==============================================ADMIN=====================================
@app.route('/adminhome')
def adminhome():
    return render_template('admin/admin_home.html')

@app.route('/add_route')
def add_route():
    return render_template('admin/add_route.html')

@app.route('/add_route_post',methods=['post'])
def add_route_post():
    frm=request.form['textfield']
    to=request.form['textfield2']
    qry="INSERT INTO `route` VALUES (NULL,%s,%s)"
    val=(frm,to)
    res=iud(qry,val)
    return '''<script>alert('Added successfull');window.location='/view_route'</script>'''

@app.route('/view_route')
def view_route():
    qry="SELECT * FROM `route`"
    res=selectall(qry)
    return render_template('admin/view_route.html',data=res)

@app.route('/delete_route')
def delete_route():
    id=request.args.get('id')
    qry="DELETE FROM `route` WHERE `route_id`=%s"
    iud(qry,id)
    return '''<script>alert('Delete successfull');window.location='/view_route'</script>'''

@app.route('/view_stop')
def view_stop():
    qry = "SELECT `stop`.*,`route`.* FROM `stop` JOIN `route` ON `route`.`route_id`=`stop`.`route_id`"
    res = selectall(qry)
    return render_template('admin/view_stop.html',data=res)

@app.route('/add_stop')
def add_stop():
    qry="SELECT * FROM `route`"
    res=selectall(qry)
    return render_template('admin/add_stop.html',data=res)

@app.route('/add_stop_post',methods=['post'])
def add_stop_post():
    route=request.form['select']
    stop_no=request.form['textfield']
    stop=request.form['textarea']
    qry = "INSERT INTO `stop` VALUES(NULL,%s,%s,%s)"
    val=(route,stop_no,stop)
    iud(qry,val)
    return '''<script>alert('Added successfull');window.location='/view_stop'</script>'''

@app.route('/delete_stop')
def delete_stop():
    id=request.args.get('id')
    qry="DELETE FROM `stop` WHERE `stop_id`=%s"
    iud(qry,id)
    return '''<script>alert('Delete successfull');window.location='/view_stop'</script>'''

@app.route('/view_complaint')
def view_complaint():
    qry="SELECT `complaint`.*,`user`.`first_name`,`last_name` FROM `complaint` JOIN `user` ON `complaint`.`login_id`=`user`.`login_id`"
    res=selectall(qry)
    return render_template('admin/view_complaint.html',data=res)

@app.route('/send_reply')
def send_reply():
    id=request.args.get('id')
    session['comid']=id
    return render_template('admin/send_reply.html')

@app.route('/reply',methods=['post'])
def reply():
    rply=request.form['textarea']
    qry="UPDATE `complaint` SET `reply`=%s WHERE `complaint_id`=%s"
    val=(rply,session['comid'])
    print(val)
    iud(qry,val)
    return '''<script>alert('Send successfull');window.location='/view_complaint'</script>'''

@app.route('/verify_bus')
def verify_bus():
    qry="SELECT `bus`.*,`login`.* FROM `bus` JOIN `login` ON `bus`.`lid`=`login`.`login_id` WHERE `login`.`type`='pending'"
    res=selectall(qry)
    return render_template('admin/verify_bus.html',data=res)

@app.route('/accept_bus')
def accept_bus():
    id=request.args.get('id')
    qry="UPDATE `login` SET `type`='bus' WHERE `login_id`=%s"
    iud(qry,id)
    return '''<script>alert('Accepted successfull');window.location='/verify_bus'</script>'''

@app.route('/reject_bus')
def reject_bus():
    id=request.args.get('id')
    qry="UPDATE `login` SET `type`='rejected' WHERE `login_id`=%s"
    iud(qry,id)
    return '''<script>alert('Rejected successfull');window.location='/verify_bus'</script>'''

@app.route('/view_bus')
def view_bus():
    qry = "SELECT `bus`.*,`login`.* FROM `bus` JOIN `login` ON `bus`.`lid`=`login`.`login_id` WHERE `login`.`type`='bus'"
    res = selectall(qry)
    return render_template('admin/view_bus.html',data=res)



@app.route('/view_user')
def view_user():
    qry = "SELECT * FROM `user`"
    res = selectall(qry)
    return render_template('admin/view_user.html',data=res)

#=================================================BUS===================================================
@app.route('/bus_reg')
def bus_reg():
    return render_template('bus/bus_reg.html')

@app.route('/reg',methods=['post'])
def reg():
    name=request.form['textfield']
    place=request.form['textfield2']
    contact=request.form['textfield3']
    vhno=request.form['textfield4']
    email=request.form['textfield5']
    uname=request.form['textfield6']
    psw=request.form['textfield7']

    qry="INSERT INTO `login` VALUES(NULL,%s,%s,'pending')"
    val=(uname,psw)
    res=iud(qry,val)

    qry1="INSERT INTO `bus` VALUES(NULL,%s,%s,%s,%s,%s,%s)"
    val1=(str(res),name,place,contact,vhno,email)
    iud(qry1,val1)
    return '''<script>alert('Added successfull');window.location='/'</script>'''

@app.route('/bushome')
def bushome():
    return render_template('bus/bus_home.html')

@app.route('/add_schedule',methods=['post'])
def add_schedule():

    tid=session['tid']
    qry="SELECT `stop`.`stop_id`,`stop_no`,`stop` FROM `stop` WHERE `route_id` IN(SELECT `route_id` FROM `trip` WHERE `trip_id`=%s) order by stop_no"
    res=selectall2(qry,tid)
    for i in res:
        time=request.form[str(i['stop_id'])]
        qry="INSERT INTO `schedule` VALUES(NULL,%s,%s,%s)"
        val=(tid,i['stop_id'],time)
        iud(qry,val)
    return '''<script>alert('Inserted successfull');window.location='/view_schedule'</script>'''


@app.route('/update_schedule',methods=['post'])
def update_schedule():

    tid=session['tid']
    qry = "SELECT schedule_id,`schedule`.`trip_time`,`stop`.`stop`,`stop_no` FROM `stop` JOIN `schedule` ON `schedule`.`stop_id`=`stop`.`stop_id` WHERE `schedule`.`trip_id`=%s ORDER BY `stop_no`"
    res = selectall2(qry, tid)
    for i in res:
        time=request.form[str(i['schedule_id'])]
        qry="UPDATE `schedule` SET `trip_time`=%s WHERE `schedule_id`=%s"
        val=(time,i['schedule_id'])
        iud(qry,val)
    return '''<script>alert('Updated successfull');window.location='/view_schedule'</script>'''


@app.route('/view_schedule')
def view_schedule():
    qry="SELECT `trip`.`trip_id`,`trip`.`trip_time`,`route`.`from`,`to` FROM `trip` JOIN `route` ON `route`.`route_id`=`trip`.`route_id` WHERE `trip`.`bus_id`=%s"
    res=selectall2(qry,session['lid'])
    return render_template('bus/view_schedule.html',td=res)

@app.route('/searchshedule',methods=['post'])
def searchshedule():
    btn=request.form['btn']
    tid=request.form['t']
    if btn=="Search":
        qry="SELECT `trip`.`trip_id`,`trip`.`trip_time`,`route`.`from`,`to` FROM `trip` JOIN `route` ON `route`.`route_id`=`trip`.`route_id` WHERE `trip`.`bus_id`=%s"
        res=selectall2(qry,session['lid'])
        qry="SELECT `schedule`.`trip_time`,`stop`.`stop`,`stop_no` FROM `stop` JOIN `schedule` ON `schedule`.`stop_id`=`stop`.`stop_id` WHERE `schedule`.`trip_id`=%s ORDER BY `stop_no`"
        res1=selectall2(qry,tid)

        return render_template('bus/view_schedule.html',td=res,time=res1,tid=str(tid))
    else:
        session['tid']=tid
        qry = "SELECT schedule_id,`schedule`.`trip_time`,`stop`.`stop`,`stop_no` FROM `stop` JOIN `schedule` ON `schedule`.`stop_id`=`stop`.`stop_id` WHERE `schedule`.`trip_id`=%s ORDER BY `stop_no`"
        res1 = selectall2(qry, tid)
        if len(res1)==0:
            qry="SELECT `stop`.`stop_id`,`stop_no`,`stop` FROM `stop` WHERE `route_id` IN(SELECT `route_id` FROM `trip` WHERE `trip_id`=%s) order by stop_no"
            res=selectall2(qry,tid)
            return render_template("bus/add_schedule.html",val=res)
        else:
            return render_template("bus/update_schedule.html", val=res1)

@app.route('/add_trip')
def add_trip():
    qry="SELECT * FROM `route`"
    res=selectall(qry)
    return render_template('bus/add_trip.html',val=res)

@app.route('/inserttrip',methods=['post'])
def inserttrip():
    rid=request.form['select']
    time=request.form['textfield']
    qry="INSERT INTO `trip` VALUES(NULL,%s,%s,%s)"
    val=(session['lid'],rid,time)
    iud(qry,val)
    return '''<script>alert('Inserted successfull');window.location='/view_trip'</script>'''


@app.route('/view_trip')
def view_trip():
    qry="SELECT `trip`.`trip_id`,`trip_time`,`route`.`from`,`to` FROM `route` JOIN `trip` ON `trip`.`route_id`=`route`.`route_id` WHERE `trip`.`bus_id`=%s"
    res=selectall2(qry,session['lid'])

    return render_template('bus/view_trip.html',val=res)


@app.route('/deletetrip')
def deletetrip():
    id=request.args.get("id")
    qry="DELETE FROM `trip` WHERE `trip_id`=%s"
    iud(qry,id)

    return '''<script>alert('Deleted successfull');window.location='/view_trip'</script>'''


app.run(debug=True)
