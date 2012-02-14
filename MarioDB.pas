unit MarioDB;//V0.01
//A unit with DataBase Related Methods

interface

uses
  Windows, SysUtils, Classes, DB, IBCustomDataSet, IBDatabase;

          ////////Procedures that use's basic units////////
Procedure MatIBBasicSQL(SelectFieldZ,DatabazeName, Extra:String;MyDataSet:TIBDataSet);
Procedure MatIBFieldList(MyFieldByName:String;var MyList:TStringList;MyDataSet:TDataSet);
Procedure MatIBFieldListConditional(MyFieldByName:String;var MyList:TStringList;MyDataSet:TIBDataSet;Fieldz,WhereFieldz,Conditionz,Databaze:String);

implementation

Procedure MatIBBasicSQL(SelectFieldZ,DatabazeName, Extra:String;MyDataSet:TIBDataSet);
Begin
  Try
   MyDataSet.DisableControls;
   MyDataSet.Active := False;
   MyDataSet.SelectSQL.Clear;
   MyDataSet.SelectSQL.Add('select '
                            + SelectFieldZ
                            + ' from '
                            + DataBazeName
                            + ' '
                            + Extra);
   MyDataSet.Open;
  Finally
   MyDataSet.EnableControls;
  End;
End;


//What It Dows
 //Retrieves A List from a selected field in a DataSet
Procedure MatIBFieldList(MyFieldByName:String;var MyList:TStringList;MyDataSet:TDataSet);
begin
  Try
   with MyDataSet do
    Begin
      MyDataSet.DisableControls;
      MyList.Sorted := True;
      MyList.Duplicates := dupIgnore;
      MyDataSet.First;
      while not Eof do
       Begin
          MyList.Add(MyDataSet.FieldByName(MyFieldByName).AsString);
        MyDataSet.Next;
       End;
     End;
  Finally
   MyDataSet.EnableControls;
  End;
End;

Procedure MatIBFieldListConditional(MyFieldByName:String;var MyList:TStringList;MyDataSet:TIBDataSet;Fieldz,WhereFieldz,Conditionz,Databaze:String);
Begin
  Try
   MyDataSet.DisableControls;
  //Call up the new condition in the DataSet
   MyDataSet.Active := False;
   MyDataSet.SelectSQL.Clear;
   MyDataSet.SelectSQL.Add('select '
                              + Fieldz
                              + ' from '
                              + Databaze
                              + ' Where '
                              + WhereFieldz
                              + ' LIKE '''
                              + Conditionz
                              + ''' ');
   MyDataSet.Open;
   MatIBFieldList(MyFieldByName,MyList,MyDataSet);
  Finally
  //Reset the Dataset
   MyDataSet.Active := False;
   MyDataSet.SelectSQL.Clear;
   MyDataSet.SelectSQL.Add('select * from '
                            + Databaze);
   MyDataSet.EnableControls;
  End;
End;




End.
