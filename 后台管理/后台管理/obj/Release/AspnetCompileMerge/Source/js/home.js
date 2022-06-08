var flag = 0;
var perioName = getQueryString("name");
var subName = getQueryVariable("subject");  
var className = getQueryVariable("class");
var short = getQueryVariable("short");

Init(perioName, subName, className, short);
OnConditionChange();
function Init(pName, sName, cName, shName) {
    
    if (pName != null) {
        $('#search').val(pName);
    }
    if (cName != null) {
        $('#subclass').val(cName);
    }
    if (sName != null) {
        //+大类改变
        $('#sub').val(sName);
        }   
    if (shName != null) {
        shorts = shName.split(",");
        var myshort = $("input[name='short']");
        for (var i = 0; i < shorts.length; i++) {
            for (var j = 0; j < myshort.length; j++) {
                if (shorts[i] == $.trim(myshort[j].parentNode.innerText))
                    myshort[j].checked = true;
            }
        }
    }
}

//后台管理.WebService1.SearchByCondition(result, GetSuccess, GetFailed);

if (perioName != null) {
   // $('#search').val(perioName);
   // OnConditionChange();
  
}
if (subName != null) {
   // $('#sub').val(subName);
   // OnConditionChange();

}
if (perioName == null && subName == null) {
    //后台管理.WebService1.GetAllPerioInfo(Rebuilt, GetFailed);
}
function getQueryVariable(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);//search,查询？后面的参数，并匹配正则
    if (r != null) return unescape(decodeURI(r[2])); return null;
}

function getQueryString(name) {
    if (typeof (name) == 'string') {
        var reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)', 'i')
        var r = window.location.search.substr(1).match(reg)
        if (r != null) {
            return decodeURIComponent(r[2])
        }
        return null
    }
    else if (Array.isArray(name)) {
        console.log('----')
        var z = []
        name.forEach(function (e, index) {
            console.log(e)
            var reg = new RegExp('(^|&)' + e + '=([^&]*)(&|$)', 'i')
            var r = window.location.search.substr(1).match(reg)
            if (r != null) {
                z[index] = decodeURIComponent(r[2])
            }
            else z[index] = ''
        })
        return z
    }
    else return null
}



function CreateTable(data) {
    $(function () {
        $('#table').bootstrapTable({
            pagination: true,
            //search: true,
            data: data,
            //showColumns: true,
            pageList: [5,10, 25, 50, 100],
            toolbar: '#toolbar',
            paginationPreText: "上一页",
            paginationNextText: "下一页",
            columns: [{
                field: '期刊名称',
                title: '期刊名称',
                valign: 'middle',
                align: 'center',
                width: 210,
            }, {
                field: '出版周期',
                title: '出版周期',
                align: 'center',
                width: 20,               
                valign: 'middle'
            }, {
                field: 'ISSN',
                title: 'ISSN',
                align: 'center',
                width: 40,
               
            }, {
                field: 'CN',
                align: 'center',
                title: 'CN',
                width: 40,
            }, {
                field: '综合影响因子',
                align: 'center',
                sortable: true,
                title: 'CNKI综合影响因子',
                width: 5,
            }, {
                field: '复合影响因子',
                align: 'center',
                sortable: true,
                title: 'CNKI复合影响因子',
                width: 20,
            }, {
                field: '',
                align: 'center',
                title: '操作',
                width: 40,
                formatter: function (cellval, row) {
                    var d = '<button  id="add" data-id="98" class="btn btn-xs btn-primary" onclick="Ondetails(\'' + row.期刊名称 + '\')">详情</button> ';                    
                    return d;
                }
            }]
        })
    })  
}

function GetFailed(result) {
    window.alert("1223");

}

function Ondetails(name) {
    layer.open({
        type: 2,  //1代表 content的值例如：'文本'；2 代表 content的值
        area: ['630px', '700px'],//显示的弹出框的宽度和高度
        title: name + "--详情",
        shade: 0.2,//遮罩层透明度
        closeBtn: 1,//0右上角的关闭 x 隐藏掉; 1显示
        shadeClose: true,   
        scrollbar: false,//屏蔽浏览器滚动条
        skin: 'my-skin', //加上边框
        //content: '<div style="height: 130px; ">conent </div> ',//type=1时
        content: ['perioDetails.aspx?name=' + name], //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no'] type=2时
        
        btn: ['关闭'],
        btnAlign: 'c',
        yes: function (index, layero)//或者使用btn1 按钮1的回调
        {
            //var body = layer.getChildFrame('body', index);
            //var iframeWin = window[layero.find('iframe')[0]['name']]; 
            layer.close(index);
        },
        cancel: function (index)//本身自带关闭弹出框功能 对应btn2的回调函数
        {

        }
    });
}



function Rebuilt(result) {
    var data1 = eval(result);
    if (flag == 1) {
        $('#table').bootstrapTable('removeAll');
        $('#table').bootstrapTable('append', data1);
    }
    else {
        CreateTable(data1);
        flag = 1;
    }
}

function subclassChange(result) {
    var subselect = $('#sub');
    var checkValue = $("#subclass").val(); //获取Select选择的Value
    后台管理.WebService1.GetSubByClass(checkValue, GetsubSuccess, GetsubFailed);
    var condition = GetCondition();
    
    
    后台管理.WebService1.SearchByCondition(condition, Rebuilt, GetsubFailed )

    function GetsubSuccess(result) {
        subselect.empty();
        $("#sub").append("<option>不限</option>");
        for (var i = 0; i < result.length; i++) {
            $("#sub").append("<option>" + result[i] + "</option>");
        }       
       
    }
    function GetsubFailed() {
        window.alert("失败");
    }
}
//没用
function subchange() {
    var checkValue = $("#sub").val(); //获取Select选择的Value
    后台管理.WebService1.GetPerioBySub(checkValue, GetSuccess, GetFailed);
    function GetSuccess(result) {
        $('#table').bootstrapTable('removeAll');       
        var data1 = eval(result);
        AppendData(data1);
        
    }
    function GetFailed() {

    }
}


function OnConditionChange() {
    var data = GetCondition();
    后台管理.WebService1.SearchByCondition(data, Rebuilt, f2);
    
    function f2(result) {
        window.alert("错误！");
    }
}

function GetCondition() {
    var name = $('#search').val();
    var sub1 = $("#sub").val();
    var subclass = $("#subclass").val();
    var Name = [name];
    var Sub;
    if (sub1 != "不限") {
        Sub = ["0", sub1];
    }
    else if (subclass != "不限") {
        Sub = ["1", subclass];
    } else {
        Sub = [sub1];
    }
   
    var Way = [];
    var Short = [];
    var Date = [];
    var obj = document.getElementsByName("way");
    for (var i = 0; i < obj.length; i++) {
        if (obj[i].checked)
            Way.push(obj[i].parentNode.innerText); //如果选中，将value添加到变量s中
    }
    obj = document.getElementsByName("short");
    for (var i = 0; i < obj.length; i++) {
        if (obj[i].checked)
            Short.push(obj[i].parentNode.innerText); //如果选中，将value添加到变量s中
    }
    obj = document.getElementsByName("date");
    for (var i = 0; i < obj.length; i++) {
        if (obj[i].checked)
            Date.push($.trim(obj[i].parentNode.innerText).substring(0, 2)); //如果选中，将value添加到变量s中
    }
    var result = [Name, Sub, Way, Short, Date];
    return result;
}



