<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="project.aspx.cs" Inherits="teste.project" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">

    <title>Pulling TestCase - Login</title>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>
<body>
    <form id="frmPrincipal" runat="server">
        <nav class="navbar navbar-default navbar-static-top">
            <div class="container-fluid">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="project.aspx">
                        <img src="images/bad.gif" style="width: 32px; height: 32px;" alt="PullingTestCase" />
                    </a>
                </div>

                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav">
                        <li class="active">
                            <button id="btnOpenProject" type="button" class="btn navbar-btn btn-primary" runat="server">
                                <span class="glyphicon glyphicon-plus"></span>Open Project
                            </button>
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Dropdown <span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="#">Action</a></li>
                                <li><a href="#">Another action</a></li>
                                <li><a href="#">Something else here</a></li>
                                <li role="separator" class="divider"></li>
                                <li><a href="#">Separated link</a></li>
                                <li role="separator" class="divider"></li>
                                <li><a href="#">One more separated link</a></li>
                            </ul>
                        </li>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Your Account<span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="#">Add new user</a></li>
                                <li><a href="#">Edit your account</a></li>
                                <li><a href="#">Change you password</a></li>
                                <li role="separator" class="divider"></li>
                                <li><a href="signout.aspx">Sign Out</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
                <!-- /.navbar-collapse -->
            </div>
            <!-- /.container-fluid -->
        </nav>
        <center>

            <!--Lista de Times e Projetos -->
            <br />
            <asp:GridView ID="gvwTeamProjects" runat="server" AutoGenerateColumns="false" AllowPaging="false" PageSize="50" width="90%" OnRowCommand="gvwTeamProjects_OnRowCommand">
                <Columns>

                    <asp:TemplateField HeaderText="Team Name" ItemStyle-Width="30%" HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Middle" HeaderStyle-BackColor="WhiteSmoke" HeaderStyle-Height="40">
                        <ItemTemplate>
                            <div align="left" style="padding: 5px;">
                                <asp:Label ID="lblTeamName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "name", "{0}")%>'></asp:Label>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Description" ItemStyle-Width="30%" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="WhiteSmoke">
                        <ItemTemplate>
                            <div align="left" style="padding: 5px;">
                                <asp:Label ID="lblTeamDescription" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "description", "{0}")%>'></asp:Label>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Project" ItemStyle-Width="30%" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="WhiteSmoke">
                        <ItemTemplate>
                            <div align="left" style="padding: 5px;">
                                <asp:Label ID="lblProjectName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "projectName", "{0}")%>'></asp:Label>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Command" ItemStyle-Width="10%" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="WhiteSmoke">
                        <ItemTemplate>
                            <div align="center" style="padding: 5px;">
                                <asp:Button ToolTip='Click here to open project' ID="btnOpen" runat="server" CommandName="Open" Text=" Open "
                                    CommandArgument='<%# DataBinder.Eval(Container.DataItem, "projectId", "{0}") + "|" + DataBinder.Eval(Container.DataItem, "Id", "{0}")%>' Style="cursor: pointer; width: 100px;" CausesValidation="False" />
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            
            <!--Lista de Iterações -->
            <br />

            <asp:GridView ID="gvwIterations" runat="server" AutoGenerateColumns="false" AllowPaging="false" PageSize="50" width="90%" OnRowCommand="gvwIterations_OnRowCommand">
                <Columns>

                    <asp:TemplateField HeaderText="Iteration Name" ItemStyle-Width="30%" HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Middle" HeaderStyle-BackColor="WhiteSmoke" HeaderStyle-Height="40">
                        <ItemTemplate>
                            <div align="left" style="padding: 5px;">
                                <asp:Label ID="lblIterationName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "name", "{0}")%>'></asp:Label>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Path" ItemStyle-Width="30%" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="WhiteSmoke">
                        <ItemTemplate>
                            <div align="left" style="padding: 5px;">
                                <asp:Label ID="lblIterationPath" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "path", "{0}")%>'></asp:Label>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Project" ItemStyle-Width="30%" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="WhiteSmoke">
                        <ItemTemplate>
                            <div align="left" style="padding: 5px;">
                                <asp:Label ID="lblAttributes" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "attributes", "{0}")%>'></asp:Label>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Command" ItemStyle-Width="10%" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="WhiteSmoke">
                        <ItemTemplate>
                            <div align="center" style="padding: 5px;">
                                <asp:Button ToolTip='Click here to open iteration' ID="btnOpen" runat="server" CommandName="Open" Text=" Open "
                                    CommandArgument='<%# DataBinder.Eval(Container.DataItem, "projectId", "{0}") + "|" + DataBinder.Eval(Container.DataItem, "teamId", "{0}") + "|" + DataBinder.Eval(Container.DataItem, "id", "{0}") %>' Style="cursor: pointer; width: 100px;" CausesValidation="False" />
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            
            <!--Lista de Iterações -->
            <br />

            <asp:GridView ID="gdvWorkItem" runat="server" AutoGenerateColumns="false" AllowPaging="false" PageSize="50" width="90%" OnRowCommand="gvwWorkItem_OnRowCommand">
                <Columns>
                    
                    <asp:TemplateField HeaderText="Id" ItemStyle-Width="30%" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="WhiteSmoke">
                        <ItemTemplate>
                            <div align="left" style="padding: 5px;">
                                <asp:Label ID="lblWorkItemId" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "workItemId", "{0}")%>'></asp:Label>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Título" ItemStyle-Width="30%" HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Middle" HeaderStyle-BackColor="WhiteSmoke" HeaderStyle-Height="40">
                        <ItemTemplate>
                            <div align="left" style="padding: 5px;">
                                <asp:Label ID="lblWorkItemTitle" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Title", "{0}")%>'></asp:Label>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Descrição" ItemStyle-Width="30%" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="WhiteSmoke">
                        <ItemTemplate>
                            <div align="left" style="padding: 5px;">
                                <asp:Label ID="lblWorkItemDescription" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Description", "{0}")%>'></asp:Label>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Command" ItemStyle-Width="10%" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="WhiteSmoke">
                        <ItemTemplate>
                            <div align="center" style="padding: 5px;">
                                <asp:Button ToolTip='Click here to open iteration' ID="btnOpen" runat="server" CommandName="Open" Text=" Open "
                                    CommandArgument='<%# DataBinder.Eval(Container.DataItem, "projectId", "{0}") + "|" + DataBinder.Eval(Container.DataItem, "teamId", "{0}") + "|" + DataBinder.Eval(Container.DataItem, "workItemId", "{0}") %>' Style="cursor: pointer; width: 100px;" CausesValidation="False" />
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            
            <!--Lista de Iterações -->
            <br />

            <asp:GridView ID="gdvTestCase" runat="server" AutoGenerateColumns="false" AllowPaging="false" PageSize="50" width="90%" OnRowCommand="gdvTestCase_OnRowCommand">
                <Columns>
                    
                    <asp:TemplateField HeaderText="Id" ItemStyle-Width="30%" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="WhiteSmoke">
                        <ItemTemplate>
                            <div align="left" style="padding: 5px;">
                                <asp:Label ID="lblWorkItemId" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "workItemId", "{0}")%>'></asp:Label>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Título" ItemStyle-Width="30%" HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Middle" HeaderStyle-BackColor="WhiteSmoke" HeaderStyle-Height="40">
                        <ItemTemplate>
                            <div align="left" style="padding: 5px;">
                                <asp:Label ID="lblWorkItemTitle" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Title", "{0}")%>'></asp:Label>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Descrição" ItemStyle-Width="30%" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="WhiteSmoke">
                        <ItemTemplate>
                            <div align="left" style="padding: 5px;">
                                <asp:Label ID="lblWorkItemDescription" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Description", "{0}")%>'></asp:Label>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Command" ItemStyle-Width="10%" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="WhiteSmoke">
                        <ItemTemplate>
                            <div align="center" style="padding: 5px;">
                                <asp:Button ToolTip='Click here to open iteration' ID="btnOpen" runat="server" CommandName="Open" Text=" Open "
                                    CommandArgument='<%# DataBinder.Eval(Container.DataItem, "projectId", "{0}") + "|" + DataBinder.Eval(Container.DataItem, "teamId", "{0}") + "|" + DataBinder.Eval(Container.DataItem, "workItemId", "{0}") %>' Style="cursor: pointer; width: 100px;" CausesValidation="False" />
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </center>
    </form>
</body>
</html>
