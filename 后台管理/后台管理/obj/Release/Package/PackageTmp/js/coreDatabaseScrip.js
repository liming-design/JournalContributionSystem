var succcount = 0;
var failedcount = 0;
function batchInsertDatabase()//批量插入
{
    var table = document.getElementById('tbRecord1');
    var args = [];
    var flag = 0;
    var rownum = table.rows.length;
    var columnum = table.rows[0].cells.length - 2;
    for (var i = 1; i < rownum; i++) {
        for (var j = 1; j < columnum; j++) {
            args.push(table.rows[i].cells[j].innerHTML);
        }
        if (i == table.rows.length - 1)
            flag = 1;
        后台管理.WebService1.CoredatabaseAdd(args, AddSuccess, Addfailed, flag);
        args = [];
    }
}

function batchInsertRelation() {
    var table = document.getElementById('tbRecord4');
    var rownum = table.rows.length;
    var args = [];
    var flag = 0;
    for (var i = 1; i < rownum; i++) {
        var pername = table.rows[i].cells[1].innerText;
        var databasestr = table.rows[i].cells[2].innerText;
        var database = databasestr.split(";");
        for (var j = 0; j < database.length; j++) {
            if (database[j] == "")
                continue;
            args.push(pername);
            args.push(database[j]);
            if (i == rownum - 1 && j == database.length - 1)
                flag = 1;//插入最后一条
            后台管理.WebService1.DatabaseIncludeAdd(args,IncludeAddSuccess, IncludeAddFailed,flag);
            args = [];
        }
    }
}


function IncludeAddSuccess(result, flag) {
    if(flag==1)
    window.alert("成功！");
}

function IncludeAddFailed(result, flag) {
    if (flag==1)
    window.alert("失败！");
}

function AddSuccess(result, flag) {
    if (result != "")
        succcount++;
    else
        failedcount++;
    if (flag == 1) {
        window.alert("成功插入" + succcount + "条！失败" + failedcount + "条！");
    }
}
function Addfailed(result) {
    failedcount++;
}

function OnAdd() {
    form = document.getElementById("formadd");
    inputs = form.getElementsByTagName("input");
    args = [];
    for (var i = 0; i < inputs.length - 1; i++) {
        args.push(inputs[i].value);
    }
    后台管理.WebService1.CoredatabaseAdd(args, AddSuccess, AddFailed, args);
}
function AddSuccess(result, args) {
    if (result != "") {
        window.alert("成功！");
        var table = document.getElementById("tbody1");
        var x = table.insertRow(0);
        for (var i = 0; i < args.length; i++) {
            x.insertCell(i).innerText = args[i];
        }        
        x.innerHTML += "<td class='edit'><button id='" + result + "' onclick='OnEdit(this)'><i class='icon-edit bigger-120'></i>编辑</button></td>";
        x.innerHTML += "<td class='delete'><button id='" + result + "' onclick='OnDelete(this)'><i class='icon-trash bigger-120'></i>删除</button></td>"
    }

}
function AddFailed() {
    window.alert("失败！");
}

function OnDelete(obj) {
    var tr = obj.parentNode.parentNode;
    var name = tr.cells[0].innerText;
    if (confirm("确定要删除'" + name + "'这一项吗?")) {
        var id = obj.id;
        后台管理.WebService1.CoreDatabaseDelete(id, Deletesuccess, Deletefailed, tr);
    }
}
function Deletesuccess(result, tr) {
    if (result == true) {
        window.alert("删除成功！");
        tbody = tr.parentNode;
        tbody.removeChild(tr);
    }
}
function Deletefailed(result) {

}

function OnEdit(obj) {
    var id = obj.id;
    layer.open({
        type: 2,  //1代表 content的值例如：'文本'；2 代表 content的值
        area: ['630px', '460px'],//显示的弹出框的宽度和高度
        title: "提示标题",
        shade: 0.2,//遮罩层透明度
        closeBtn: 1,//0右上角的关闭 x 隐藏掉; 1显示
        shadeClose: true,
        scrollbar: false,//屏蔽浏览器滚动条
        // skin: 'layui-layer-rim', //加上边框
        //content: '<div style="height: 130px; ">conent </div> ',//type=1时
        content: ['coreDatabaseEdit.aspx?id=' + id, 'no'], //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no'] type=2时

        btn: ['取消'], // 三个按钮的text值
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



