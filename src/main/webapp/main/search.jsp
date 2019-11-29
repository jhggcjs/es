<%@page contentType="text/html; utf-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <link rel="stylesheet" href="../boot/css/bootstrap.min.css">
    <link rel="stylesheet" href="../jqgrid/css/jquery-ui.css">
    <link rel="stylesheet" href="../jqgrid/css/trirand/ui.jqgrid-bootstrap.css">
    <script src="../boot/js/jquery-3.3.1.min.js"></script>
    <script src="../boot/js/bootstrap.min.js"></script>
    <script src="../jqgrid/js/trirand/jquery.jqGrid.min.js"></script>
    <script src="../jqgrid/js/trirand/i18n/grid.locale-cn.js"></script>
    <script src="../boot/js/ajaxfileupload.js"></script>
    <script src="../kindeditor/kindeditor-all-min.js"></script>
    <script src="../kindeditor/lang/zh-CN.js"></script>
</head>
<script>
    $(function () {

        $("#search").click(function () {
            var value = $("#searchText").val();
            $("#articleList").jqGrid({
                url:"${pageContext.request.contextPath}/artitle/search?query="+value,
                editurl:"${pageContext.request.contextPath}/article/edit",
                type:"post",
                datatype:"json",
                colNames:["id","标题","内容","操作"],
                colModel:[
                    {name:"id",hidden:true},//<input id="id">
                    {name:"title",editable:true},
                    {name:"brief",hidden:true},
                    {name:"xxx",
                        formatter:function (a, b, c) {
                            return "<a href='#' onclick=\"lookModel('"+c.id+"')\">查看详情</a>"
                        }
                    }
                ],
                styleUI:"Bootstrap",
                autowidth:true,
                pager:"#articlePage",
                rowNum:4,
                page:1,
                rowList:[4,8,12],
                multiselect:true,
                viewrecords:true,
                height:"60%"
            }).jqGrid("navGrid","#articlePage",{edit:false,add:false,del:true,search:false,refresh:false},{},{}, {});

        });


        function showModel() {
            $("#myModal").modal("show");
            $("#modal_footer").html(
                "<button type=\"button\" onclick='addArticle()' class=\"btn btn-primary\">添加</button>\n" +
                "<button type=\"button\" class=\"btn btn-danger\" data-dismiss=\"modal\">取消</button>"
            );
            //editor
            KindEditor.create('#editor',{
                uploadJson:"${pageContext.request.contextPath}/article/upload",
                filePostName:"img",
                fileManagerJson:"${pageContext.request.contextPath}/article/getAllImg",
                allowFileManager:true,
                afterBlur:function () {
                    this.sync();
                }
            });
            $("#addArticleFrom")[0].reset();
            KindEditor.html("#editor","");
        }
        function addArticle() {
            $.ajax({
                url:"${pageContext.request.contextPath}/article/add",
                datatype:"json",
                type:"post",
                data:$("#addArticleFrom").serialize(),
                success:function (data) {
                    $("#myModal").modal("toggle");
                    $("#articleList").trigger("reloadGrid");
                }
            })
        }

        function lookModel(id) {
            $("#addArticleFrom")[0].reset();
            $("#myModal").modal("show");
            var value=$("#articleList").getRowData(id);
            $("#title").val(value.title);
            KindEditor.create('#editor',{
                uploadJson:"${pageContext.request.contextPath}/article/upload",
                filePostName:"img",
                fileManagerJson:"${pageContext.request.contextPath}/article/getAllImg",
                allowFileManager:true,
                afterBlur:function () {
                    this.sync();
                }
            });
            KindEditor.html("#editor","");
            KindEditor.appendHtml("#editor",value.brief);

            $("#modal_footer").html(
                "<button type=\"button\" class=\"btn btn-danger\" data-dismiss=\"modal\">取消</button>"
            );

        }
    });
</script>


<body>
<nav class="navbar navbar-default">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="#">文章检索</a>
        </div>
            <form class="navbar-form navbar-left">
                <div class="form-group">
                    <input type="text" class="form-control" placeholder="Search" id="searchText">
                </div>
                <button type="submit" class="btn btn-default" id="search">搜索</button>
            </form>
     </div>

</nav>
<div>
    <!-- Nav tabs -->
    <ul class="nav nav-tabs" role="tablist">
        <li role="presentation" class="active"><a href="#home"  aria-controls="home" role="tab" data-toggle="tab">文章列表</a></li>
        <li role="presentation"><a href="#profile" onclick="showModel()" aria-controls="profile" role="tab" data-toggle="tab">添加文章</a></li>
    </ul>
</div>

<table id="articleList"></table>
<div id="articlePage"></div>

<div class="modal fade" id="myModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content" style="width:750px">
            <!--模态框标题-->
            <div class="modal-header">
                <!--
                    用来关闭模态框的属性:data-dismiss="modal"
                -->
                <button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
                <h4 class="modal-title">编辑文章信息</h4>
            </div>

            <!--模态框内容体-->
            <div class="modal-body">
                <form action="#" class="form-horizontal"
                      id="addArticleFrom">
                    <div class="form-group">
                        <label class="col-sm-1 control-label">标题</label>
                        <div class="col-sm-5">
                            <input type="text" name="title" id="title" placeholder="请输入标题" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-12">
                            <textarea id="editor" name="brief" style="width:700px;height:300px;"></textarea>
                        </div>
                    </div>
                    <input id="addInsertImg" name="insertImg" hidden>
                </form>
            </div>
            <!--模态页脚-->
            <div class="modal-footer" id="modal_footer">
            </div>
        </div>
    </div>
</div>
</body>
</html>