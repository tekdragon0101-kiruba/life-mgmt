/* checksum : b08d8ad005abdeece58531214637d87a */
@cds.external : true
@Common.SideEffects : {
  $Type: 'Common.SideEffectsType',
  TargetEntities: [ '/RewardsMgmtService.EntityContainer/Categories' ]
}
action RewardsMgmtService.createCategory(
  @Common.Label : '{i18n>name}'
  @Common.FieldControl : #Mandatory
  Name : String(100),
  @Common.Label : '{i18n>description}'
  @Common.FieldControl : #Mandatory
  Description : String(500),
  @Common.Label : '{i18n>isChildCategory}'
  @Common.ValueListWithFixedValues : true
  @Common.ValueList : {
    $Type: 'Common.ValueListType',
    CollectionPath: 'isChildCategory',
    Parameters: [
      {
        $Type: 'Common.ValueListParameterInOut',
        LocalDataProperty: isChild,
        ValueListProperty: 'isChild'
      }
    ]
  }
  isChild : Boolean default 'false',
  @Common.Label : 'Parent Category'
  @Common.ValueListWithFixedValues : true
  @Common.ValueList : {
    $Type: 'Common.ValueListType',
    CollectionPath: 'Categories',
    Parameters: [
      {
        $Type: 'Common.ValueListParameterInOut',
        LocalDataProperty: parentCategory_ID,
        ValueListProperty: 'ID'
      },
      {
        $Type: 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'Name'
      }
    ]
  }
  @Common.Text : Name
  @Common.Text.@UI.TextArrangement : #TextOnly
  parentCategory_ID : String(36)
);

@cds.external : true
@cds.persistence.skip : true
entity RewardsMgmtService.Rewards {
  @Common.Label : '{i18n>id}'
  @Core.ComputedDefaultValue : true
  key ID : UUID not null;
  @odata.Precision : 7
  @odata.Type : 'Edm.DateTimeOffset'
  @UI.HiddenFilter : true
  @UI.ExcludeFromNavigationContext : true
  @Core.Immutable : true
  @Core.Computed : true
  @Common.Label : '{i18n>CreatedAt}'
  createdAt : Timestamp;
  /** {i18n>UserID.Description} */
  @UI.HiddenFilter : true
  @UI.ExcludeFromNavigationContext : true
  @Core.Immutable : true
  @Core.Computed : true
  @Common.Label : '{i18n>CreatedBy}'
  createdBy : String(255);
  @odata.Precision : 7
  @odata.Type : 'Edm.DateTimeOffset'
  @UI.HiddenFilter : true
  @UI.ExcludeFromNavigationContext : true
  @Core.Computed : true
  @Common.Label : '{i18n>ChangedAt}'
  modifiedAt : Timestamp;
  /** {i18n>UserID.Description} */
  @UI.HiddenFilter : true
  @UI.ExcludeFromNavigationContext : true
  @Core.Computed : true
  @Common.Label : '{i18n>ChangedBy}'
  modifiedBy : String(255);
  @Common.Label : '{i18n>name}'
  @Common.FieldControl : #Mandatory
  Name : String(100);
  @Common.Label : '{i18n>description}'
  Description : String(500);
  @Common.Label : '{i18n>category}'
  category : Association to one RewardsMgmtService.Categories {  };
  @Common.Label : '{i18n>category}'
  category_ID : UUID;
  @Common.Label : '{i18n>pointsRequired}'
  PointsRequired : Integer;
  @odata.Precision : 0
  @odata.Type : 'Edm.DateTimeOffset'
  @Common.Label : '{i18n>validFrom}'
  @Core.ComputedDefaultValue : true
  ValidFrom : DateTime;
  @odata.Precision : 0
  @odata.Type : 'Edm.DateTimeOffset'
  @Common.Label : '{i18n>validTo}'
  ValidTo : DateTime;
};

@cds.external : true
@cds.persistence.skip : true
entity RewardsMgmtService.Categories {
  @Common.Label : '{i18n>id}'
  @Core.ComputedDefaultValue : true
  key ID : UUID not null;
  @Common.Label : '{i18n>categoryName}'
  @Common.FieldControl : #Mandatory
  Name : String(100);
  @Common.Label : '{i18n>ca}'
  Description : String(500);
  @Common.Label : '{i18n>parentCategory}'
  parentCategory : Association to one RewardsMgmtService.Categories {  };
  @Common.Label : '{i18n>parentCategory}'
  parentCategory_ID : UUID;
  child : Association to one RewardsMgmtService.Categories {  };
} actions {
  @Common.SideEffects : {
    $Type: 'Common.SideEffectsType',
    TargetEntities: [ '/RewardsMgmtService.EntityContainer/Categories' ]
  }
  @Common.IsActionCritical : true
  action deleteCategory(
    ![in] : $self
  );
  @Common.SideEffects : {
    $Type: 'Common.SideEffectsType',
    TargetEntities: [ '/RewardsMgmtService.EntityContainer/Categories' ]
  }
  action editCategory(
    _it : $self,
    @UI.ParameterDefaultValue : ![_it/Name]
    @Common.Label : '{i18n>categoryName}'
    @Common.FieldControl : #Mandatory
    Name : String(100),
    @UI.ParameterDefaultValue : ![_it/Description]
    @Common.Label : '{i18n>categoryDescription}'
    @Common.FieldControl : #Mandatory
    Description : String(500),
    @UI.ParameterDefaultValue : ![_it/parentCategory_ID]
    @Common.Label : 'Parent Category'
    @Common.ValueListWithFixedValues : true
    @Common.ValueList : {
      $Type: 'Common.ValueListType',
      CollectionPath: 'Categories',
      Parameters: [
        {
          $Type: 'Common.ValueListParameterInOut',
          LocalDataProperty: parentCategory,
          ValueListProperty: 'ID'
        },
        {
          $Type: 'Common.ValueListParameterDisplayOnly',
          ValueListProperty: 'Name'
        }
      ]
    }
    parentCategory : String(36)
  );
};

@cds.external : true
@cds.persistence.skip : true
@Common.DraftRoot : {
  $Type: 'Common.DraftRootType',
  ActivationAction: 'RewardsMgmtService.draftActivate',
  EditAction: 'RewardsMgmtService.draftEdit',
  PreparationAction: 'RewardsMgmtService.draftPrepare'
}
entity RewardsMgmtService.RewardResources {
  @Common.Label : '{i18n>id}'
  @Core.ComputedDefaultValue : true
  key ID : UUID not null;
  @Common.Label : '{i18n>name}'
  @Common.FieldControl : #Mandatory
  Name : String(100);
  @Common.Label : '{i18n>description}'
  Description : String(500);
  @Common.Label : '{i18n>URL}'
  Url : String(500);
  @Common.Label : '{i18n>category}'
  category : Association to one RewardsMgmtService.Categories {  };
  @Common.Label : '{i18n>category}'
  category_ID : UUID;
  @UI.Hidden : true
  key IsActiveEntity : Boolean not null default true;
  @UI.Hidden : true
  HasActiveEntity : Boolean not null default false;
  @UI.Hidden : true
  HasDraftEntity : Boolean not null default false;
  @UI.Hidden : true
  DraftAdministrativeData : Association to one RewardsMgmtService.DraftAdministrativeData {  };
  SiblingEntity : Association to one RewardsMgmtService.RewardResources {  };
} actions {
  action draftPrepare(
    ![in] : $self,
    SideEffectsQualifier : LargeString
  ) returns RewardsMgmtService.RewardResources;
  action draftActivate(
    ![in] : $self
  ) returns RewardsMgmtService.RewardResources;
  action draftEdit(
    ![in] : $self,
    PreserveChanges : Boolean
  ) returns RewardsMgmtService.RewardResources;
};

@cds.external : true
@cds.persistence.skip : true
entity RewardsMgmtService.isChildCategory {
  key isChild : Boolean not null;
};

@cds.external : true
@cds.persistence.skip : true
@Common.Label : '{i18n>Draft_DraftAdministrativeData}'
entity RewardsMgmtService.DraftAdministrativeData {
  @UI.Hidden : true
  @Common.Label : '{i18n>Draft_DraftUUID}'
  @Core.ComputedDefaultValue : true
  key DraftUUID : UUID not null;
  @odata.Precision : 7
  @odata.Type : 'Edm.DateTimeOffset'
  @Common.Label : '{i18n>Draft_CreationDateTime}'
  CreationDateTime : Timestamp;
  @Common.Label : '{i18n>Draft_CreatedByUser}'
  CreatedByUser : String(256);
  @UI.Hidden : true
  @Common.Label : '{i18n>Draft_DraftIsCreatedByMe}'
  DraftIsCreatedByMe : Boolean;
  @odata.Precision : 7
  @odata.Type : 'Edm.DateTimeOffset'
  @Common.Label : '{i18n>Draft_LastChangeDateTime}'
  LastChangeDateTime : Timestamp;
  @Common.Label : '{i18n>Draft_LastChangedByUser}'
  LastChangedByUser : String(256);
  @Common.Label : '{i18n>Draft_InProcessByUser}'
  InProcessByUser : String(256);
  @UI.Hidden : true
  @Common.Label : '{i18n>Draft_DraftIsProcessedByMe}'
  DraftIsProcessedByMe : Boolean;
};

@cds.external : true
type RewardsMgmtService.inCategory {
  @Common.Label : '{i18n>name}'
  @Common.FieldControl : #Mandatory
  Name : String(100);
  @Common.Label : '{i18n>description}'
  @Common.FieldControl : #Mandatory
  Description : String(500);
  @Common.Label : '{i18n>isChildCategory}'
  @Common.ValueListWithFixedValues : true
  @Common.ValueList : {
    $Type: 'Common.ValueListType',
    CollectionPath: 'isChildCategory',
    Parameters: [
      {
        $Type: 'Common.ValueListParameterInOut',
        LocalDataProperty: isChild,
        ValueListProperty: 'isChild'
      }
    ]
  }
  isChild : Boolean default false;
  @Common.Label : 'Parent Category'
  @Common.ValueListWithFixedValues : true
  @Common.ValueList : {
    $Type: 'Common.ValueListType',
    CollectionPath: 'Categories',
    Parameters: [
      {
        $Type: 'Common.ValueListParameterInOut',
        LocalDataProperty: parentCategory_ID,
        ValueListProperty: 'ID'
      },
      {
        $Type: 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'Name'
      }
    ]
  }
  @Common.Text : Name
  @Common.Text.@UI.TextArrangement : #TextOnly
  parentCategory_ID : String(36);
};

@cds.external : true
service RewardsMgmtService {};

