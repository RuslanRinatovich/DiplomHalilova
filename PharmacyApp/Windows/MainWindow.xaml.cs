﻿using Microsoft.Maps.MapControl.WPF;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using EduInstitutesApp.Models;
using EduInstitutesApp.Windows;
using System.IO;
using Word = Microsoft.Office.Interop.Word;
using System.Windows.Controls.Primitives;

namespace EduInstitutesApp
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        bool _login = false;
        int _itemcount = 0;
        public MainWindow()
        {
            InitializeComponent();
            LoadData();
            BtnEdit.Visibility = Visibility.Hidden;
            

        }

        void ShowAllPins(List<Organization> edus)
        {
            ToggleButtonShowAllPins.IsChecked = true;
            MapZel.Children.Clear();
            foreach (Organization organization in edus)
            {
                Location pinLocation = new Location(organization.Latitude, organization.Longitude);

                Pushpin pin = new Pushpin();
                pin.Location = pinLocation;
                pin.ToolTip = $"{organization.Title}\n{organization.Address}";
                MapZel.Children.Add(pin);
            }
        }
        void LoadData()
        {
            var categorises = OrganizationDBEntities.GetContext().Categories.OrderBy(p => p.Title).ToList();
            categorises.Insert(0, new Category
            {
                Title = "Все типы"
            }
            );
            ComboCategories.ItemsSource = categorises;
            ComboCategories.SelectedIndex = 0;

            var worktimes = OrganizationDBEntities.GetContext().WorkTimes.OrderBy(p => p.Title).ToList();
            worktimes.Insert(0, new WorkTime
            {
                Title = "Все типы"
            }
            );
            ComboWorkTime.ItemsSource = worktimes;
            ComboWorkTime.SelectedIndex = 0;

            List<Organization> Organizations = OrganizationDBEntities.GetContext().Organizations.OrderBy(p => p.Title).ToList();
            LViewGoods.ItemsSource = OrganizationDBEntities.GetContext().Organizations.OrderBy(p => p.Title).ToList();

            ShowAllPins(Organizations);
            _itemcount = LViewGoods.Items.Count;
            // отображение количества записей
            TextBlockCount.Text = $" Результат запроса: {_itemcount} записей из {_itemcount}";
        }

        private void MapZel_MouseMove(object sender, MouseEventArgs e)
        {
            //e.Handled = true;

            Point mousePosition = e.GetPosition(MapZel);
            //mousePosition.X -= 258;
            //mousePosition.Y -= 66;
            Location pinLocation = MapZel.ViewportPointToLocation(mousePosition);

            // Pushpin pin = new Pushpin();
            //pin.Location = pinLocation;


            TextBlockCoords.Text = $"{pinLocation.Latitude}: {pinLocation.Longitude}";
            //MainMap.Children.Add(pin);
        }


        void ExportWord(Organization selected)
        {

            string fileName = Directory.GetCurrentDirectory() + "\\" + "AboutEdu" + ".dotx";
            Word.Application wrdApp = new Word.Application();
            try
            {

                Word.Document document = wrdApp.Documents.Add(fileName);
                document.Bookmarks["Name"].Range.Text = selected.Title;
                document.Bookmarks["Address"].Range.Text = selected.Address;

                document.Bookmarks["Email"].Range.Text = selected.Site;
                document.Bookmarks["Info"].Range.Text = selected.WorkTime.Title.ToString();
                document.Bookmarks["Phone"].Range.Text = selected.Phone;

                
                var i = OrganizationDBEntities.GetContext().ServiceOrganizations.Where(x => x.OrganizationId == selected.Id).ToList();
                //LbServices.Items.Clear();
                List<Service> services = OrganizationDBEntities.GetContext().Services.OrderBy(p => p.Title).ToList();
                int k = 0;
                List<Service> services1 = new List<Service>();
                string s = "";
                foreach (ServiceOrganization x in i)
                {
                    k++;
                    Service service = services.Find(z => z.Id == x.ServiceId);
                    services1.Add(service);
                    s += service.Title + "\n";
                }


                document.Bookmarks["Services"].Range.Text = s;
                document.Bookmarks["Category"].Range.Text = selected.Category.Title;

                object oRange = document.Bookmarks["Photo"].Range;
                object saveWithDocument = true;
                object missing = Type.Missing;
                string pictureName = selected.GetPhoto;
                document.InlineShapes.AddPicture(pictureName, ref missing, ref saveWithDocument, ref oRange);
                document.Bookmarks["Rate"].Range.Text = selected.Rate.ToString();


                //document.SaveAs("В");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString());
                wrdApp.Quit();
            }
            finally
            {
                wrdApp.Visible = true;
                wrdApp.ScreenUpdating = true;
            }



        }


        private void BtnCloseClick(object sender, RoutedEventArgs e)
        {
            Close();
        }

        private void Window_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {
            // на экране отображается форма с двумя кнопками
            MessageBoxResult x = MessageBox.Show("Вы действительно хотите закрыть приложение?",
            "Выйти", MessageBoxButton.OKCancel, MessageBoxImage.Question);
            if (x == MessageBoxResult.Cancel)
                e.Cancel = true;
        }

        private void PackIcon_MouseUp(object sender, MouseButtonEventArgs e)
        {
            Location pinLocation = new Location(55.84589999, 48.5066666);
            MapZel.Center = pinLocation;
        }

   

        // Поиск товаров, которые содержат данную поисковую строку
        private void TBoxSearchTextChanged(object sender, TextChangedEventArgs e)
        {
            UpdateData();
        }
        // Поиск товаров конкретного производителя
        private void ComboTypeSelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            UpdateData();
        }
        /// <summary>
        /// Метод для фильтрации и сортировки данных
        /// </summary>
        private void UpdateData()
        {
            LbServices.ItemsSource = null;
            // получаем текущие данные из бд
            var currentOrganizations = OrganizationDBEntities.GetContext().Organizations.OrderBy(p => p.Title).ToList();
            // выбор только тех товаров, которые принадлежат данному производителю
            if (ComboCategories.SelectedIndex > 0)
                currentOrganizations = currentOrganizations.Where(p => p.CategoryId == (ComboCategories.SelectedItem as Category).Id).ToList();

            if (ComboWorkTime.SelectedIndex > 0)
                currentOrganizations = currentOrganizations.Where(p => p.WorkTimeId == (ComboWorkTime.SelectedItem as WorkTime).Id).ToList();
            // выбор тех товаров, в названии которых есть поисковая строка
            currentOrganizations = currentOrganizations.Where(p => p.Title.ToLower().Contains(TBoxSearch.Text.ToLower())).ToList();


            // В качестве источника данных присваиваем список данных
            LViewGoods.ItemsSource = currentOrganizations;
            ShowAllPins(currentOrganizations);
            // отображение количества записей
            TextBlockCount.Text = $" Результат запроса: {currentOrganizations.Count} записей из {_itemcount}";
        }
        // сортировка товаров 
        private void ComboSortSelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            UpdateData();
        }

        private void LViewGoods_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (LViewGoods.SelectedIndex >= 0)
            {
                Organization Organization = (LViewGoods.SelectedItem as Organization);
                var i = OrganizationDBEntities.GetContext().ServiceOrganizations.Where(x => x.OrganizationId == Organization.Id).ToList();
                //LbServices.Items.Clear();
                List<Service> services = OrganizationDBEntities.GetContext().Services.OrderBy(p => p.Title).ToList();
                int k = 0;
                List<Service> services1 = new List<Service>();
                foreach (ServiceOrganization x in i)
                {
                    k++;
                    Service service = services.Find(z => z.Id == x.ServiceId);
                    services1.Add(service);
                }

                LbServices.ItemsSource = services1;
            }
        }

   
        private void BtnAdminClick(object sender, RoutedEventArgs e)
        {
            if (_login)
            {
                MessageBoxResult messageBoxResult = MessageBox.Show($"Выйти из панели администратора??? ", "Выход", MessageBoxButton.OKCancel,
MessageBoxImage.Question);
                if (messageBoxResult == MessageBoxResult.OK)
                {
                    IconBtnKey.Kind = MaterialDesignThemes.Wpf.PackIconKind.Login;
                    _login = false;
                    BtnEdit.Visibility = Visibility.Hidden;
                    TbPass.Password = "";
                    TbLogin.Text = "";
                    return;
                }
            }
            else
                AccessWindow.IsOpen = true;
        }

        private void BtnCancelClick(object sender, RoutedEventArgs e)
        {
            AccessWindow.IsOpen = false;
        }

        private void BtnOkClick(object sender, RoutedEventArgs e)
        {
            try
            {  //загрузка всех пользователей из БД в список
                List<User> users = OrganizationDBEntities.GetContext().Users.ToList();
                //попытка найти пользователя с указанным паролем и логином
                //если такого пользователя не будет обнаружено то переменная u будет равна null
                User u = users.FirstOrDefault(p => p.Password == TbPass.Password && p.Username == TbLogin.Text);

                if (u != null)
                {
                    // логин и пароль корректные запускаем главную форму приложения
                    BtnEdit.Visibility = Visibility.Visible;
                    IconBtnKey.Kind = MaterialDesignThemes.Wpf.PackIconKind.Logout;
                    _login = true;
                    AccessWindow.IsOpen = false;
                }
                else
                {
                    MessageBox.Show("Не верный логин или пароль");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }

        }



        private void BtnEditClick(object sender, RoutedEventArgs e)
        {
            AdminWindow adminWindow = new AdminWindow();
            adminWindow.ShowDialog();
            LoadData();



        }

        private void IconLeft_MouseUp(object sender, MouseButtonEventArgs e)
        {
            e.Handled = true;

            Point mousePosition = e.GetPosition(MapZel);
            Location pinLocation = MapZel.ViewportPointToLocation(mousePosition);

            MapZel.Center = pinLocation;

        }

        private void IconBottom_MouseUp(object sender, MouseButtonEventArgs e)
        {
            e.Handled = true;

            Point mousePosition = e.GetPosition(MapZel);
            Location pinLocation = MapZel.ViewportPointToLocation(mousePosition);

            MapZel.Center = pinLocation;
        }

        private void IconTop_MouseUp(object sender, MouseButtonEventArgs e)
        {
            e.Handled = true;

            Point mousePosition = e.GetPosition(MapZel);
            Location pinLocation = MapZel.ViewportPointToLocation(mousePosition);

            MapZel.Center = pinLocation;
        }

        private void IconRight_MouseUp(object sender, MouseButtonEventArgs e)
        {
            e.Handled = true;

            Point mousePosition = e.GetPosition(MapZel);
            Location pinLocation = MapZel.ViewportPointToLocation(mousePosition);

            MapZel.Center = pinLocation;
        }

        private void IconLeft_MouseEnter(object sender, MouseEventArgs e)
        {
            MaterialDesignThemes.Wpf.PackIcon packIcon = sender as MaterialDesignThemes.Wpf.PackIcon;
            packIcon.Opacity = 1;

        }

        private void IconLeft_MouseLeave(object sender, MouseEventArgs e)
        {
            MaterialDesignThemes.Wpf.PackIcon packIcon = sender as MaterialDesignThemes.Wpf.PackIcon;
            packIcon.Opacity = 0.5;
        }

        private void IconSatelliteMode_MouseUp(object sender, MouseButtonEventArgs e)
        {
            if (MapZel.Mode is AerialMode)
            {
                MapZel.Mode = new RoadMode();
            }
            else { MapZel.Mode = new AerialMode(true); }
            
        }

        private void BtnOk_Click(object sender, RoutedEventArgs e)
        {
            DialogHostMoreInformation.IsOpen = false;
        }

        private void BtnMoreInfo_Click(object sender, RoutedEventArgs e)
        {
            Organization selected = (sender as Button).DataContext as Organization;
            DialogHostMoreInformation.DataContext = selected;
            DialogHostMoreInformation.IsOpen = true;
        }

        private void BtnMaximizeMin_Click(object sender, RoutedEventArgs e)
        {
            if (this.WindowState == WindowState.Normal)
            {
                this.WindowState = WindowState.Maximized;
                IconMaximize.Kind = MaterialDesignThemes.Wpf.PackIconKind.WindowRestore;
            }
            else
            {
                this.WindowState = WindowState.Normal;
                IconMaximize.Kind = MaterialDesignThemes.Wpf.PackIconKind.WindowMaximize;
            }

        }

        private void TextBlock_MouseDown(object sender, MouseButtonEventArgs e)
        {
            if (e.ChangedButton == MouseButton.Left)
                this.DragMove();
        }

        private void BtnMinimize_Click(object sender, RoutedEventArgs e)
        {
            this.WindowState = WindowState.Minimized;
        }

        private void BtnPrintInfo_Click(object sender, RoutedEventArgs e)
        {
            Organization selected = (sender as Button).DataContext as Organization;
            ExportWord(selected);
        }

        private void BtnShowPin_Click(object sender, RoutedEventArgs e)
        {
            MapZel.Children.Clear();
            Organization selected = (sender as Button).DataContext as Organization;
            Location pinLocation = new Location(selected.Latitude, selected.Longitude);
            //ToggleButtonShowPins.
            ToggleButtonShowAllPins.IsChecked = false;
            Pushpin pin = new Pushpin();
            pin.Location = pinLocation;
            var converter = new System.Windows.Media.BrushConverter();
            var brush = (Brush)converter.ConvertFromString("#FFFF00");
            MapZel.Center = pinLocation;
            pin.Background = brush;
            pin.ToolTip = $"{selected.Title}\n{selected.Address}";
            MapZel.Children.Add(pin);
        }

   

        private void ToggleButtonShowAllPins_Checked(object sender, RoutedEventArgs e)
        {
            List<Organization> Organizations = OrganizationDBEntities.GetContext().Organizations.OrderBy(p => p.Title).ToList();

            ShowAllPins(Organizations);
        }

        private void ToggleButtonShowAllPins_Unchecked(object sender, RoutedEventArgs e)
        {
            MapZel.Children.Clear();
        }

        private void ComboWorkTime_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            UpdateData();
        }
    }
}
