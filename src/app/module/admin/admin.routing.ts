import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { AdminLayout } from '@layouts';
import {
  DashboardComponent,
  PostsComponent,
  EditCategoryPostComponent,
  EditPostComponent,
  NavigationComponent,
  ParameterComponent,
  DataComponent,
  EditDataComponent,
  EditTypeDataComponent,
  CodeTypesComponent,
  EditProfileComponent,
  EditCodeTypeComponent,
  UserComponent,
  PasswordUserComponent,
  EditUserComponent,
  DetailUserComponent,
} from '@pages';

const routes: Routes = [
  {
    path: '',
    component: AdminLayout,
    children: [
      {
        path: 'dashboard',
        component: DashboardComponent,
      },
      {
        path: 'post',
        component: PostsComponent,
      },
      {
        path: 'navigation',
        component: NavigationComponent,
      },
      {
        path: 'post/:id/edit',
        component: EditPostComponent,
      },
      {
        path: 'post/add',
        component: EditPostComponent,
      },
      {
        path: 'post/categories/:id/edit',
        component: EditCategoryPostComponent,
      },
      {
        path: 'post/categories/add',
        component: EditCategoryPostComponent,
      },
      {
        path: 'data',
        component: DataComponent,
      },
      {
        path: 'data/add',
        component: EditDataComponent,
      },
      {
        path: 'data/:id/edit',
        component: EditDataComponent,
      },
      {
        path: 'data/type/add',
        component: EditTypeDataComponent,
      },
      {
        path: 'data/type/:id/edit',
        component: EditTypeDataComponent,
      },
      {
        path: 'edit-profile',
        component: EditProfileComponent,
      },
      {
        path: 'code-types',
        component: CodeTypesComponent,
      },
      {
        path: 'code-types/:type/add',
        component: EditCodeTypeComponent,
      },
      {
        path: 'code-types/:type/:id/edit',
        component: EditCodeTypeComponent,
      },
      {
        path: 'parameter',
        component: ParameterComponent,
      },
      {
        path: 'customer-account',
        component: UserComponent,
      },
      {
        path: 'customer-account/add',
        component: EditUserComponent,
      },
      {
        path: 'customer-account/:id',
        component: DetailUserComponent,
      },
      {
        path: 'customer-account/:id/edit',
        component: EditUserComponent,
      },
      {
        path: 'customer-account/:id/password',
        component: PasswordUserComponent,
      },
      {
        path: 'internal-account',
        component: UserComponent,
      },
      {
        path: 'internal-account/add',
        component: EditUserComponent,
      },
      {
        path: 'internal-account/:id',
        component: DetailUserComponent,
      },
      {
        path: 'internal-account/:id/edit',
        component: EditUserComponent,
      },
      {
        path: 'internal-account/:id/password',
        component: PasswordUserComponent,
      },
      { path: '**', redirectTo: 'dashboard', pathMatch: 'full' },
    ],
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class AdminRouting {}
