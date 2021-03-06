 #-*- encoding : utf-8 -*-
require Rails.root.join('lib/rails_admin/extensions/cancan/authorization_adapter')

RailsAdmin.config do |config|

  config.main_app_name = ["Lcmat", "Administração"]

  config.current_user_method { current_user } #auto-generated

  config.authorize_with :cancan

  # CKeditor models (begin)
  config.model Ckeditor::Asset do
    visible false
  end

 config.model Ckeditor::Picture do
   label "Imagem"
   label_plural "Imagens"
   navigation_label 'Arquivos adicionados através do editor'
   weight 1

   edit do
     field(:data) { label 'Imagem' }
   end

   list do
     field(:data) { label 'Imagem' }
     field(:created_at) { label 'Criado em' }
     field(:updated_at) { label 'Atualizado em' }
   end
 end

 config.model Ckeditor::AttachmentFile do
   label 'Arquivo'
   navigation_label 'Arquivos adicionados através do editor'
   weight 1

   edit do
     field(:data) { label 'Arquivo' }
   end

   list do
     field(:data) do
       label 'Arquivo'
        pretty_value do # used in list view columns and show views, defaults to formatted_value for non-association fields
         "<a href='#{value.url}' target='_blank'>#{value.original_filename}</a>".html_safe
       end
     end

     field(:created_at) { label 'Criado em' }
     field(:updated_at) { label 'Atualizado em' }
   end
 end
 # CKeditor models (end)

  config.model CourseFile do
    visible false
    edit do
      field :file
    end
  end

  config.model Course do
    list do
      field :name
      field :coordinator
    end

    edit do
      field :name
      field :description do
        bootstrap_wysihtml5 true
        html_attributes do
          {
            :cols => '120',
            :rows => '20'
          }
        end
      end
      field :coordinator
      field :professors
      field :course_files
    end
  end


  config.model Configuration do

    edit do
      group :email do
        label 'Configurações de email'
        field :email
      end

      group :info_search do
        label 'Informações para buscadores'

        field :keywords do
           help 'Separadas por vírgula. Recomendável no máximo 10 palavras chave.'
           html_attributes do
            {
              :cols => '70',
              :rows => '7'
            }
          end
        end
        field :description do
          help 'Descrição utilizada pelos buscadores. Recomendável até 160 caracteres.'
          html_attributes do
            {
              :cols => '70',
              :rows => '7'
            }
          end
        end

        field :google_analytics do
          html_attributes do
            {
              :cols => '70',
              :rows => '7'
            }
          end
        end
        field :footer do
          html_attributes do
            {
              :cols => '70',
              :rows => '7'
            }
          end
        end
      end
    end
  end

  config.model Page do
    list do
      field :title
      field :published
    end

    edit do
      field :title
      field(:content) do
        bootstrap_wysihtml5 true
        html_attributes do
          {
            :cols => '120',
            :rows => '20'
          }
        end
      end
      field :published
    end
  end

  config.model Informative do
    list do
      field :title
      field :published
    end

    edit do
      field :title
      field(:content) do
        ckeditor true
      end
      field :published
    end
  end


  config.model Professor do
    list do
      field :photo do
        thumb_method :small
      end
      field :name
      field :user do
        label 'E-mail'
      end
    end

    edit do
      group :basic_info do
        label 'Informações básicas'
        active do
          bindings[:object].has_basic_info_errors?
        end

        field :name
        field :photo do
          thumb_method :small
        end
        field :curriculum do
        bootstrap_wysihtml5 true
        html_attributes do
          {
            :cols => '120',
            :rows => '20'
          }
        end
      end
      end
      group :links do
        label 'Links'
        active do
          bindings[:object].has_links_errors?
        end

        field :dropbox do
          hint 'Conheça o <a href="http://dropbox.com">Dropbox</a> e compartilhe arquivos com seus alunos.'.html_safe
        end
        field :linkedin
        field :lattes
      end
      group :access do
        label 'E-mail e senha de acesso'
        active do
          user = bindings[:object].user
          errors = bindings[:object].errors

          if user.present?
            (errors.any? and user.changed?) || (user and user.errors.any?)
          end
        end

        field :user do
          label '<i class="icon-user"></i>'.html_safe
          active true
          help 'Clique para alterar o e-mail ou senha'
        end
      end
    end
  end


  config.model User do
    object_label_method { :email }

    list do
      field :email
    end

    create do
      field :email
      field(:password) do
        label 'Senha'
        help 'Digite a senha do novo usuário'
      end

      field :password_confirmation do
        label 'Confirme a senha'
        help 'Confirme a senha do novo usuário'
      end
    end

    edit do
      field :email
      field(:password) do
        label 'Senha'
        help 'Digite uma nova senha caso deseje modificar a atual'
      end

      field :password_confirmation do
        label 'Confirme a senha'
        help 'Confirme a senha caso deseje mudar a senha atual'
      end
    end
  end
end

