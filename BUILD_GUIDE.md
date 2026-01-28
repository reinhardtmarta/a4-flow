# Guia de Build e Publicação - A4 Flow

## 1️⃣ Gerar Keystore (Chave de Assinatura)

### Opção A: Gerar Localmente (Recomendado para Desenvolvimento)

```bash
# Gere uma chave de assinatura
keytool -genkey -v -keystore ~/a4flow-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias a4flow

# Você será solicitado a fornecer:
# - Senha da keystore
# - Nome e sobrenome
# - Unidade organizacional
# - Organização
# - Cidade
# - Estado
# - Código do país (BR)
```

### Opção B: Gerar no GitHub (CI/CD)

Se preferir usar GitHub Actions para gerar o APK automaticamente:

1. **Crie o keystore localmente** (siga Opção A)
2. **Encode em Base64**:
```bash
base64 -i ~/a4flow-key.jks -o keystore-base64.txt
cat keystore-base64.txt
```

3. **Adicione como Secret no GitHub**:
   - Vá para: Settings → Secrets and variables → Actions
   - Clique em "New repository secret"
   - Nome: `KEYSTORE_BASE64`
   - Valor: Cole o conteúdo do arquivo base64

4. **Adicione outras secrets**:
   - `KEYSTORE_PASSWORD`: Sua senha do keystore
   - `KEY_ALIAS`: `a4flow`
   - `KEY_PASSWORD`: Sua senha da chave

## 2️⃣ Configurar Android para Assinatura

### Arquivo: `android/key.properties`

```properties
storePassword=SUA_SENHA_KEYSTORE
keyPassword=SUA_SENHA_CHAVE
keyAlias=a4flow
storeFile=../a4flow-key.jks
```

⚠️ **Não commite este arquivo no Git!** Adicione ao `.gitignore`:

```bash
echo "android/key.properties" >> .gitignore
```

### Arquivo: `android/app/build.gradle`

Adicione antes de `buildTypes`:

```gradle
signingConfigs {
    release {
        keyAlias keystoreProperties['keyAlias']
        keyPassword keystoreProperties['keyPassword']
        storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
        storePassword keystoreProperties['storePassword']
    }
}

buildTypes {
    release {
        signingConfig signingConfigs.release
    }
}
```

## 3️⃣ Gerar APK de Release

### Comando Local

```bash
# Copie o keystore para a raiz do projeto
cp ~/a4flow-key.jks .

# Crie o arquivo key.properties
cat > android/key.properties << EOF
storePassword=SUA_SENHA
keyPassword=SUA_SENHA
keyAlias=a4flow
storeFile=../../a4flow-key.jks
EOF

# Gere o APK
flutter build apk --release

# APK gerado em:
# build/app/outputs/flutter-apk/app-release.apk
```

### Via GitHub Actions (Automático)

Crie `.github/workflows/build-apk.yml`:

```yaml
name: Build APK

on:
  push:
    branches: [ master ]
  pull_request:
    branches: [ master ]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v3
    
    - name: Setup Flutter
      uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.19.0'
    
    - name: Decode Keystore
      run: |
        echo "${{ secrets.KEYSTORE_BASE64 }}" | base64 -d > a4flow-key.jks
    
    - name: Create key.properties
      run: |
        cat > android/key.properties << EOF
        storePassword=${{ secrets.KEYSTORE_PASSWORD }}
        keyPassword=${{ secrets.KEY_PASSWORD }}
        keyAlias=${{ secrets.KEY_ALIAS }}
        storeFile=../../a4flow-key.jks
        EOF
    
    - name: Get dependencies
      run: flutter pub get
    
    - name: Build APK
      run: flutter build apk --release
    
    - name: Upload APK
      uses: actions/upload-artifact@v3
      with:
        name: app-release.apk
        path: build/app/outputs/flutter-apk/app-release.apk
```

## 4️⃣ Publicar em Lojas Alternativas

### 📱 F-Droid (Recomendado - Código Aberto)

1. **Prepare o repositório**:
   - Fork: https://github.com/f-droid/fdroiddata
   - Crie um arquivo `metadata/com.example.a4flow.yml`

2. **Exemplo de metadata**:
```yaml
Categories:
  - Office
License: GPL-3.0-only
AuthorName: Seu Nome
AuthorEmail: seu@email.com
WebSite: https://github.com/reinhardtmarta/a4-flow
SourceCode: https://github.com/reinhardtmarta/a4-flow
IssueTracker: https://github.com/reinhardtmarta/a4-flow/issues

Builds:
  - versionName: '1.0.0'
    versionCode: 1
    commit: v1.0.0
    gradle:
      - yes
```

3. **Faça um Pull Request**

### 📦 APKPure

1. Acesse: https://apkpure.com/developer-center
2. Faça upload do APK
3. Preencha informações do app
4. Aguarde aprovação (24-48h)

### 🛒 Amazon Appstore

1. Acesse: https://developer.amazon.com/apps-and-games
2. Registre-se como desenvolvedor
3. Crie uma nova aplicação
4. Faça upload do APK
5. Preencha metadados

### 📲 APKMirror (Apenas Distribuição)

- Envie para: https://www.apkmirror.com/upload/
- Requer aprovação manual

## 5️⃣ Versioning e Releases

### Atualize `pubspec.yaml`:

```yaml
version: 1.0.0+1
```

### Crie Release no GitHub:

```bash
git tag v1.0.0
git push origin v1.0.0
```

Depois crie a release no GitHub com o APK anexado.

## 6️⃣ Checklist Antes de Publicar

- [ ] Testou o APK em pelo menos 2 dispositivos
- [ ] Atualizou versão em `pubspec.yaml`
- [ ] Atualizou `CHANGELOG.md`
- [ ] Removeu dados de teste
- [ ] Verificou permissões no `AndroidManifest.xml`
- [ ] Testou todas as funcionalidades principais
- [ ] Verificou performance e consumo de bateria
- [ ] Criou screenshots para as lojas
- [ ] Escreveu descrição clara do app

## 7️⃣ Troubleshooting

### "Keystore not found"
```bash
# Verifique o caminho do keystore
ls -la android/key.properties
cat android/key.properties
```

### "Invalid keystore format"
```bash
# Regenere o keystore
keytool -genkey -v -keystore ~/a4flow-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias a4flow
```

### "Build failed: Gradle error"
```bash
# Limpe o build
flutter clean
flutter pub get
flutter build apk --release -v
```

## 📚 Referências

- [Flutter Build Documentation](https://flutter.dev/docs/deployment/android)
- [F-Droid Submission Guide](https://f-droid.org/en/docs/Submitting_Apps/)
- [APKPure Developer Guide](https://apkpure.com/developer-center)
- [Android Keystore Documentation](https://developer.android.com/studio/publish/app-signing)

---

**Dúvidas?** Abra uma issue no repositório ou consulte a documentação oficial do Flutter.
